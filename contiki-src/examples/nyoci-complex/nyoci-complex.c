/*	@file nyoci-complex.c
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

#include "assert-macros.h"

#include "nyoci-task.h"
#include "watchdog.h"
#include "net/ip/resolv.h"
#if WEBSERVER
#include "webserver-nogui.h"
#endif

PROCESS_NAME(nyoci_simple);
PROCESS(nyoci_simple, "LibNyoci Simple Demo");

/*---------------------------------------------------------------------------*/
AUTOSTART_PROCESSES(
	&resolv_process,
	&nyoci_task,
	&nyoci_simple,
#if WEBSERVER
	&webserver_nogui_process,
#endif
	NULL
);
/*---------------------------------------------------------------------------*/

#if !defined(__SDCC) && defined(SDCC_REVISION)
#define __SDCC  1
#endif

#if defined(__SDCC) && !defined(snprintf)
#warning SNPRINTF NOT IMPLEMENTED, SPRINTF COULD OVERFLOW!
#define snprintf(dest,n,fmt,...) sprintf(dest,fmt,__VA_ARGS__)
#endif

#include <libnyoci/libnyoci.h>
#include <libnyociextra/nyoci-node-router.h>
#include <libnyociextra/nyoci-var-handler.h>
#include "led-node.h"
#include "sensor-node.h"
#include "dev/leds.h"
#include "lib/sensors.h"

#if RAVEN_LCD_INTERFACE
#include "raven-lcd.h"
#endif

#ifndef DISPLAY_MESSAGE
#if RAVEN_LCD_INTERFACE
#define DISPLAY_MESSAGE(content,content_length)		raven_lcd_display_messagen(content,content_length)
#else
#define DISPLAY_MESSAGE(content,content_length)		printf("MSG: %s\n",content)
#endif
#endif

//////////////////////////////////
// ELAPSED TIME NODE

nyoci_status_t
elapsed_time_request_handler(
	nyoci_node_t		node
) {
	nyoci_status_t ret = NYOCI_STATUS_NOT_ALLOWED;
	const coap_code_t method = nyoci_inbound_get_code();

	if(method==COAP_METHOD_GET) {
		ret = nyoci_outbound_begin_response(COAP_RESULT_205_CONTENT);
		require_noerr(ret, bail);

		ret = nyoci_outbound_set_var_content_unsigned_long_int(clock_seconds());
		require_noerr(ret, bail);

		ret = nyoci_outbound_send();
		require_noerr(ret, bail);
	}
bail:
	return ret;
}

nyoci_node_t
create_elapsed_time_node(
	nyoci_node_t ret,
	nyoci_node_t parent,
	const char* name
) {
	ret = nyoci_node_init(ret,(void*)parent, name);

	ret->request_handler = (void*)elapsed_time_request_handler;

	return ret;
}

//////////////////////////////////
// PROCESS LIST NODE

nyoci_status_t
processes_request_handler(
	nyoci_node_t		node
) {
	nyoci_status_t ret = NYOCI_STATUS_NOT_ALLOWED;
	const coap_code_t method = nyoci_inbound_get_code();

//	uint32_t block_option = 0x03;
//	uint32_t block_start = 0;
//	uint32_t block_stop = 0;
//	coap_size_t max_len = 0;
//
//	{
//		const uint8_t* value;
//		coap_size_t value_len;
//		coap_option_key_t key;
//		while((key=nyoci_inbound_next_option(&value, &value_len))!=COAP_OPTION_INVALID) {
//			if(key == COAP_OPTION_BLOCK2) {
//				uint8_t i;
//				block_option = 0;
//				for(i = 0; i < value_len; i++)
//					block_option = (block_option << 8) + value[i];
//			}
//		}
//	}

	if(method==COAP_METHOD_GET) {
		struct process* iter;
		int size=0;
		char* content;
		coap_size_t content_len=0;

		ret = nyoci_outbound_begin_response(COAP_RESULT_205_CONTENT);
		if(ret) goto bail;

		nyoci_outbound_add_option_uint(COAP_OPTION_CONTENT_TYPE, COAP_CONTENT_TYPE_TEXT_CSV);

//		max_len = nyoci_outbound_get_space_remaining()-2;
//
//		// Here we are making sure our data will fit,
//		// and adjusting our block-option size accordingly.
//		do {
//			struct coap_block_info_s block_info;
//			coap_decode_block(&block_info, block_option);
//			block_start = block_info.block_offset;
//			block_stop = block_info.block_offset + block_info.block_size;
//
//			if(max_len<(block_stop-block_start) && block_option!=0 && !block_info.block_offset) {
//				block_option--;
//				block_stop = 0;
//				continue;
//			}
//		} while(0==block_stop);
//
//		ret = nyoci_outbound_add_option_uint(COAP_OPTION_BLOCK2,block_option);
//		require_noerr(ret,bail);

		content = nyoci_outbound_get_content_ptr(&content_len);
		if(!content) goto bail;

		iter = process_list;

		while(iter && (content_len-size)>0) {
			size += snprintf(content+size,content_len-size,"%p, %u, %s\n",iter,iter->state,PROCESS_NAME_STRING(iter));
			iter = iter->next;
		}

		require_action(content_len>=size,bail,ret=NYOCI_STATUS_MESSAGE_TOO_BIG);

		ret = nyoci_outbound_set_content_len(size);
		if(ret) goto bail;

		ret = nyoci_outbound_send();
	}
bail:
	return ret;
}

nyoci_node_t
create_process_list_node(nyoci_node_t node,nyoci_node_t parent,const char* name) {

	node = nyoci_node_init(node,(void*)parent, name);

	node->request_handler = (void*)processes_request_handler;

	return node;
}

//////////////////////////////////
// RESET NODE

nyoci_status_t
reset_request_handler(
	nyoci_node_t		node
) {
	nyoci_status_t ret = NYOCI_STATUS_NOT_ALLOWED;
	const coap_code_t method = nyoci_inbound_get_code();

	if(method==COAP_METHOD_POST) {
		watchdog_reboot();
	}

	return ret;
}

nyoci_node_t
create_reset_node(nyoci_node_t node,nyoci_node_t parent,const char* name) {

	node = nyoci_node_init(node,(void*)parent, name);

	node->request_handler = (void*)reset_request_handler;

	return node;
}

//////////////////////////////////
// BEEP NODE

nyoci_status_t
beep_request_handler(
	nyoci_node_t		node
) {
	nyoci_status_t ret = NYOCI_STATUS_NOT_ALLOWED;
	const coap_code_t method = nyoci_inbound_get_code();

	if(method==COAP_METHOD_POST) {
#if RAVEN_LCD_INTERFACE
		raven_lcd_beep();
#else
		printf("BEEP!\n\a");
#endif
		ret = NYOCI_STATUS_OK;
	}

	return ret;
}

nyoci_node_t
create_beep_node(nyoci_node_t node,nyoci_node_t parent,const char* name) {

	node = nyoci_node_init(node,(void*)parent, name);

	node->request_handler = (void*)beep_request_handler;

	return node;
}

//////////////////////////////////
// RPL NODE

#if 0 && UIP_CONF_IPV6_RPL
#include "net/ipv6/uip-ds6.h"
#include "rpl.h"
extern uip_ds6_nbr_t uip_ds6_nbr_cache[];
extern uip_ds6_route_t uip_ds6_routing_table[];
extern uip_ds6_netif_t uip_ds6_if;

nyoci_status_t
rpl_request_handler(
	nyoci_node_t		node
) {
	nyoci_status_t ret = NYOCI_STATUS_NOT_ALLOWED;
	const coap_code_t method = nyoci_inbound_get_code();

	if(method==COAP_METHOD_GET) {
		int size=0,i,j;
		char* content;
		coap_size_t content_len=0;

		ret = nyoci_outbound_begin_response(COAP_RESULT_205_CONTENT);
		if(ret) goto bail;

		nyoci_outbound_add_option_uint(COAP_OPTION_CONTENT_TYPE, COAP_CONTENT_TYPE_TEXT_PLAIN);

		content = nyoci_outbound_get_content_ptr(&content_len);
		if(!content) goto bail;

#define ADD_6ADDR(addr) size+=snprintf(content+size,content_len-size,"%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x", ((uint8_t *)addr)[0], ((uint8_t *)addr)[1], ((uint8_t *)addr)[2], ((uint8_t *)addr)[3], ((uint8_t *)addr)[4], ((uint8_t *)addr)[5], ((uint8_t *)addr)[6], ((uint8_t *)addr)[7], ((uint8_t *)addr)[8], ((uint8_t *)addr)[9], ((uint8_t *)addr)[10], ((uint8_t *)addr)[11], ((uint8_t *)addr)[12], ((uint8_t *)addr)[13], ((uint8_t *)addr)[14], ((uint8_t *)addr)[15])

		size+=snprintf(content+size,content_len-size,"Addresses [%u max]\n",UIP_DS6_ADDR_NB);
		for (i=0;i<UIP_DS6_ADDR_NB;i++) {
			if (uip_ds6_if.addr_list[i].isused) {
				size+=snprintf(content+size,content_len-size,"\t");
				ADD_6ADDR(&uip_ds6_if.addr_list[i].ipaddr);
				size+=snprintf(content+size,content_len-size,"\n");
			}
		}

		size+=snprintf(content+size,content_len-size,"\nNeighbors [%u max]\n",UIP_DS6_NBR_NB);
		for(i = 0,j=1; i < UIP_DS6_NBR_NB; i++) {
			if(uip_ds6_nbr_cache[i].isused) {
				size+=snprintf(content+size,content_len-size,"\t");
				ADD_6ADDR(&uip_ds6_nbr_cache[i].ipaddr);
				size+=snprintf(content+size,content_len-size,"\n");
				j=0;
			}
		}
		if (j) 	size+=snprintf(content+size,content_len-size,"\t<NONE>\n");

//		size+=snprintf(content+size,content_len-size,"\nRoutes [%u max]\n",UIP_DS6_ROUTE_NB);
//		for(i = 0,j=1; i < UIP_DS6_ROUTE_NB; i++) {
//			if(uip_ds6_routing_table[i].isused) {
//				size+=snprintf(content+size,content_len-size,"\t");
//				ADD_6ADDR(&uip_ds6_if.addr_list[i].ipaddr);
//				size+=snprintf(content+size,content_len-size,"/%u (via ", uip_ds6_routing_table[i].length);
//				ADD_6ADDR(&uip_ds6_routing_table[i].nexthop);
//				if(uip_ds6_routing_table[i].state.lifetime < 600) {
//					size+=snprintf(content+size,content_len-size,") %lus\n", uip_ds6_routing_table[i].state.lifetime);
//				} else {
//					size+=snprintf(content+size,content_len-size,")\n");
//				}
//				j=0;
//			}
//		}
//		if (j) 	size+=snprintf(content+size,content_len-size,"\t<NONE>\n");

		ret = nyoci_outbound_set_content_len(size);
		if(ret) goto bail;

		ret = nyoci_outbound_send();
	}
bail:
	return ret;

}

nyoci_node_t
create_rpl_node(nyoci_node_t node,nyoci_node_t parent,const char* name) {

	node = nyoci_node_init(node,(void*)parent, name);

	node->request_handler = (void*)rpl_request_handler;

	return node;
}

#endif




//////////////////////////////////
// HOSTNAME NODE
#if RESOLV_CONF_SUPPORTS_MDNS
nyoci_status_t
hostname_request_handler(
	nyoci_node_t		node
) {
	nyoci_status_t ret = NYOCI_STATUS_NOT_ALLOWED;
	const coap_code_t method = nyoci_inbound_get_code();

	if(method==COAP_METHOD_GET) {
		ret = nyoci_outbound_begin_response(COAP_RESULT_205_CONTENT);
		if(ret) goto bail;

		ret = nyoci_outbound_append_content(resolv_get_hostname(),-1);
		if(ret) goto bail;

		ret = nyoci_outbound_send();
	} else if(method==COAP_METHOD_PUT) {
		if(nyoci_inbound_get_content_len())
			resolv_set_hostname(nyoci_inbound_get_content_ptr());
		ret = 0;
	}
bail:
	return ret;
}

nyoci_node_t
create_hostname_node(nyoci_node_t node,nyoci_node_t parent,const char* name) {

	node = nyoci_node_init(node,(void*)parent, name);

	node->request_handler = (void*)hostname_request_handler;

	return node;
}
#endif // #if RESOLV_CONF_SUPPORTS_MDNS

//////////////////////////////////
// MAIN THREAD

PROCESS_THREAD(nyoci_simple, ev, data)
{
	static struct nyoci_node_s root_node = {};

	static struct nyoci_node_s reset_node;
	static struct nyoci_node_s uptime_node;
	static struct nyoci_node_s processes_node;
	static struct nyoci_node_s hostname_node;
	static struct nyoci_node_s beep_node;
	static struct nyoci_node_s rpl_node;

	PROCESS_BEGIN();

	// Set up the root node.
	nyoci_node_init(&root_node,NULL,NULL);

	// Set up the node router.
	nyoci_set_default_request_handler(nyoci, &nyoci_node_router_handler, &root_node);


	// Create the "reset" node.
	create_reset_node(
		&reset_node,
		&root_node,
		"reset"
	);

	// Create the "uptime" node.
	create_elapsed_time_node(
		&uptime_node,
		&root_node,
		"uptime"
	);

	// Create the "processes" node.
	create_process_list_node(
		&processes_node,
		&root_node,
		"processes"
	);

	// Create the "beep" node.
	create_beep_node(
		&beep_node,
		&root_node,
		"beep"
	);

#if RESOLV_CONF_SUPPORTS_MDNS
	// Create the "hostname" node.
	create_hostname_node(
		&hostname_node,
		&root_node,
		"hostname"
	);
#endif // RESOLV_CONF_MDNS_RESPONDER

#if 0 && UIP_CONF_IPV6_RPL
	// Create the "hostname" node.
	create_rpl_node(
		&rpl_node,
		&root_node,
		"rpl"
	);
#endif // UIP_CONF_IPV6_RPL


	{
		static struct nyoci_node_s led_node;
		static struct nyoci_var_handler_s variable_handler = { .func = &led_var_func };
		leds_init();
		nyoci_node_init(&led_node, &root_node, "leds");
		led_node.request_handler = (void*)&nyoci_var_handler_request_handler;
		led_node.context = &variable_handler;
		led_node.has_link_content = true;
	}

#if !CONTIKI_TARGET_MINIMAL_NET
	static struct nyoci_var_handler_s sensor_variable_handler = { .func = &sensor_var_func };
	static struct nyoci_node_s sensor_node;

	nyoci_node_init(&sensor_node, &root_node, "sensors");
	sensor_node.request_handler = (void*)&nyoci_var_handler_request_handler;
	sensor_node.context = &sensor_variable_handler;
	sensor_node.has_link_content = true;
	sensor_node.is_observable = true;

	const struct sensors_sensor* sensor;
	for(sensor = sensors_first();sensor;sensor = sensors_next(sensor)) {
		sensor->configure(SENSORS_ACTIVE,1);
	}

	do {
		PROCESS_WAIT_EVENT();

		if (ev == sensors_event) {
			nyoci_observable_trigger(&sensor_variable_handler.observable,NYOCI_OBSERVABLE_BROADCAST_KEY,0);
		}
	} while(1);
#endif

	PROCESS_END();
}
