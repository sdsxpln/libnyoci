/*	@file nyoci-plat-openssl.h
**	@author Robert Quattlebaum <darco@deepdarc.com>
**
**	Copyright (C) 2017 Robert Quattlebaum
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

#ifndef NYOCI_nyoci_plat_openssl_h
#define NYOCI_nyoci_plat_openssl_h

#include "libnyoci.h"
#include "nyoci-plat-tls-func.h"
#include "btree.h"

#include <sys/types.h>

#define NYOCI_PLAT_TLS_OPENSSL 1

NYOCI_BEGIN_C_DECLS

struct ssl_st;
struct ssl_ctx_st;

struct nyoci_openssl_session_s {
	struct bt_item_s bt_item;
	nyoci_sockaddr_t sockaddr_local;
	nyoci_sockaddr_t sockaddr_remote;
	nyoci_timestamp_t created;
	nyoci_timestamp_t last_activity;
	coap_msg_id_t msg_id;
	struct nyoci_timer_s dtls_timer;
	struct ssl_st* ssl;
};

struct nyoci_plat_tls_s {
	struct ssl_ctx_st* ssl_ctx;

	// The SSL session for the current transaction
	struct nyoci_openssl_session_s* curr_session;

	// The pending SSL session for the next inbound transaction
	struct ssl_st* next_ssl;

	struct nyoci_openssl_session_s* sessions;
};

NYOCI_END_C_DECLS

#endif // NYOCI_nyoci_plat_openssl_h
