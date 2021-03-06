/*	@file nyoci-list.c
**	@author Robert Quattlebaum <darco@deepdarc.com>
**
**	Copyright (C) 2017  Robert Quattlebaum
**
**	Permission is hereby granted, free of charge, to any person
**	obtaining a copy of this software and associated
**	documentation files (the "Software"), to deal in the
**	Software without restriction, including without limitation
**	the rights to use, copy, modify, merge, publish, distribute,
**	sublicense, and/or sell copies of the Software, and to
**	permit persons to whom the Software is furnished to do so,
**	subject to the following conditions:
**
**	The above copyright notice and this permission notice shall
**	be included in all copies or substantial portions of the
**	Software.
**
**	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
**	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
**	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
**	PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
**	OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
**	OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
**	OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
**	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/*	TODO: This function should be re-written using the new design patterns.
**	SEC-TODO: This function is abusing strlcat()!
*/

#if HAVE_CONFIG_H
#include <config.h>
#endif

#ifndef VERBOSE_DEBUG
#define VERBOSE_DEBUG 0
#endif

#ifndef DEBUG
#define DEBUG VERBOSE_DEBUG
#endif

#include "assert-macros.h"
#include "nyoci-node-router.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "nyoci-missing.h"
#include "nyoci-helpers.h"
#include "nyoci-logging.h"
#include "url-helpers.h"

nyoci_status_t
nyoci_node_list_request_handler(
	nyoci_node_t		node
) {
	nyoci_status_t ret = 0;
	char* replyContent;
	coap_size_t content_break_threshold = 256;
	const char* prefix = node->name;

	// The path "/.well-known/core" is a special case. If we get here,
	// we know that it isn't being handled explicitly, so we just
	// show the root listing as a reasonable default.
	if (!node->parent) {
		if (nyoci_inbound_option_strequal_const(COAP_OPTION_URI_PATH, ".well-known")) {
			nyoci_inbound_next_option(NULL, NULL);
			if (nyoci_inbound_option_strequal_const(COAP_OPTION_URI_PATH, "core")) {
				nyoci_inbound_next_option(NULL, NULL);
				prefix = "";
			} else {
				ret = NYOCI_STATUS_NOT_ALLOWED;
				goto bail;
			}
		}
	}

	if (nyoci_inbound_option_strequal_const(COAP_OPTION_URI_PATH,"")) {
		// Eat the trailing '/'.
		nyoci_inbound_next_option(NULL, NULL);
		if(prefix[0]) prefix = NULL;
	}

	// Check over the headers to make sure they are sane.
	{
		coap_option_key_t key;
		const uint8_t* value;
		coap_size_t value_len;
		while ((key = nyoci_inbound_next_option(&value, &value_len)) != COAP_OPTION_INVALID) {
			require_action(key != COAP_OPTION_URI_PATH, bail, ret = NYOCI_STATUS_NOT_FOUND);

			if (key == COAP_OPTION_URI_QUERY) {
				// Skip URI query components for now.
			} else if (key == COAP_OPTION_ACCEPT) {
				if ( (value_len != 1)
				  || (*value != COAP_CONTENT_TYPE_APPLICATION_LINK_FORMAT)
				) {
					// We only support application/link-format
					// TODO: Consider supporting json
					nyoci_outbound_quick_response(COAP_RESULT_415_UNSUPPORTED_MEDIA_TYPE, NULL);
					ret = NYOCI_STATUS_OK;
					goto bail;
				}
			} else {
				if (COAP_OPTION_IS_CRITICAL(key)) {
					ret = NYOCI_STATUS_BAD_OPTION;
					assert_printf(
						"Unrecognized option %d, \"%s\"",
						key,
						coap_option_key_to_cstr(key, false)
					);
					goto bail;
				}
			}
		}
	}

	// Node should always be set by the time we get here.
	require_action(node, bail, ret = NYOCI_STATUS_BAD_ARGUMENT);

	if (NULL != node->children) {
#if NYOCI_NODE_ROUTER_USE_BTREE
		node = bt_first(node->children);
#else
		node = node->children;
#endif
	} else {
		node = NULL;
	}

	ret = nyoci_outbound_begin_response(COAP_RESULT_205_CONTENT);
	require_noerr(ret, bail);

	ret = nyoci_outbound_add_option_uint(COAP_OPTION_CONTENT_TYPE, COAP_CONTENT_TYPE_APPLICATION_LINK_FORMAT);
	require_noerr(ret, bail);

	replyContent = nyoci_outbound_get_content_ptr(&content_break_threshold);
	require(NULL != replyContent, bail);

	replyContent[0] = 0;

	while(node) {
		nyoci_node_t next;
		const char* node_name = node->name;

		if (!node_name) {
			break;
		}

		if((strlen(node_name) + 4) >
				(content_break_threshold - strlen(replyContent) - 3)) {
			break;
		}

		strlcat(replyContent, "<", content_break_threshold);

		if(prefix) {
			size_t len = strlen(replyContent);
			if(content_break_threshold-1>len)
				url_encode_cstr(replyContent+len, prefix, content_break_threshold - len);
			strlcat(replyContent, "/", content_break_threshold);
		}

		{
			size_t len = strlen(replyContent);
			if(content_break_threshold-1>len)
				url_encode_cstr(replyContent+len, node_name, content_break_threshold - len);
		}

		if(node->children) {
			strlcat(replyContent, "/", content_break_threshold);
		}

		strlcat(replyContent, ">", content_break_threshold);

		if(node->children || node->has_link_content) {
			strlcat(replyContent, ";ct=40", content_break_threshold);
		}

		if(node->is_observable) {
			strlcat(replyContent, ";obs", content_break_threshold);
		}

#if NYOCI_NODE_ROUTER_USE_BTREE
		next = bt_next((void*)node);
#else
		next = ll_next((void*)node);
#endif

		node = next;
#if NYOCI_ADD_NEWLINES_TO_LIST_OUTPUT
		strlcat(replyContent, &",\n"[!node], content_break_threshold);
#else
		strlcat(replyContent, &","[!node], content_break_threshold);
#endif
	}

	ret = nyoci_outbound_set_content_len((coap_size_t)strlen(replyContent));
	require_noerr(ret,bail);

	ret = nyoci_outbound_send();

bail:
	return ret;
}
