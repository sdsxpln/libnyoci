# This SED script is for helping to convert projects
# that were previously using SMCP to use LibNyoci.

s:<smcp/smcp\.h>:<libnyoci/libnyoci\.h>:;
s:"smcp-variable_handler\.h":<libnyociextra/libnyociextra\.h>:;
s:"smcp-node-router\.h":<libnyociextra/libnyociextra\.h>:;
s:"url-helpers\.h":<libnyoci/url-helpers\.h>:;
s:"string-utils\.h":<libnyoci/string-utils\.h>:;
s:"btree\.h":<libnyoci/btree\.h>:;
s:"ll\.h":<libnyoci/ll\.h>:;
s:<smcp/fasthash\.h>:<libnyoci/fasthash\.h>:;
s/<smcp\/url-helpers\.h>/<libnyoci\/url-helpers\.h>/;
/"smcp-internal\.h"/d;
/"smcp-logging\.h"/d;
/"smcp-observable\.h"/d;
/"smcp-transaction\.h"/d;
/"smcp-async\.h"/d;
/"smcp-helpers\.h"/d;
/"smcp-timer\.h"/d;
s/<smcp\/smcp-variable_handler\.h>/<libnyociextra\/libnyociextra\.h>/;
s/<smcp\/smcp-node-router\.h>/<libnyociextra\/libnyociextra\.h>/;
/<smcp\/smcp-internal\.h>/d;
/<smcp\/smcp-logging\.h>/d;
/<smcp\/smcp-observable\.h>/d;
/<smcp\/smcp-transaction\.h>/d;
/<smcp\/smcp-async\.h>/d;
/<smcp\/smcp-missing\.h>/d;
/<smcp\/coap\.h>/d;
s/smcp_method_t/coap_code_t/g;
s/smcp_set_current_instance/nyoci_set_current_instance/g;
s/smcp_get_current_instance/nyoci_get_current_instance/g;
s/smcp_inbound_is_dupe/nyoci_inbound_is_dupe/g;
s/smcp_inbound_is_fake/nyoci_inbound_is_fake/g;
s/smcp_inbound_is_multicast/nyoci_inbound_is_multicast/g;
s/smcp_inbound_get_code/nyoci_inbound_get_code/g;
s/___smcp_check_version/___nyoci_check_version/g;
s/coap_code_to_cstr/coap_code_to_cstr/g;
s/coap_content_type_to_cstr/coap_content_type_to_cstr/g;
s/coap_decode_block/coap_decode_block/g;
s/coap_decode_option/coap_decode_option/g;
s/coap_decode_uint32/coap_decode_uint32/g;
s/coap_dump_header/coap_dump_header/g;
s/coap_encode_option/coap_encode_option/g;
s/coap_insert_option/coap_insert_option/g;
s/coap_option_key_to_cstr/coap_option_key_to_cstr/g;
s/coap_option_strequal/coap_option_strequal/g;
s/coap_option_value_is_string/coap_option_value_is_string/g;
s/gSMCPInstance/gNyociInstance/g;
s/smcp_handle_request/nyoci_handle_request/g;
s/smcp_convert_status_to_result_code/nyoci_convert_status_to_result_code/g;
s/smcp_count_observers/nyoci_count_observers/g;
s/smcp_create/nyoci_create/g;
s/smcp_finish_async_response/nyoci_finish_async_response/g;
s/smcp_get_current_instance/nyoci_get_current_instance/g;
s/smcp_get_next_msg_id/nyoci_get_next_msg_id/g;
s/smcp_get_timeout/nyoci_get_timeout/g;
s/smcp_handle_timers/nyoci_handle_timers/g;
s/smcp_inbound_get_content_len/nyoci_inbound_get_content_len/g;
s/smcp_inbound_get_content_ptr/nyoci_inbound_get_content_ptr/g;
s/smcp_inbound_get_content_type/nyoci_inbound_get_content_type/g;
s/smcp_inbound_get_flags/nyoci_inbound_get_flags/g;
s/smcp_inbound_get_packet/nyoci_inbound_get_packet/g;
s/smcp_inbound_get_packet_length/nyoci_inbound_get_packet_length/g;
s/smcp_inbound_get_path/nyoci_inbound_get_path/g;
s/smcp_inbound_is_related_to_async_response/nyoci_inbound_is_related_to_async_response/g;
s/smcp_inbound_next_option/nyoci_inbound_next_option/g;
s/smcp_inbound_option_strequal/nyoci_inbound_option_strequal/g;
s/smcp_inbound_packet_process/nyoci_inbound_packet_process/g;
s/smcp_inbound_peek_option/nyoci_inbound_peek_option/g;
s/smcp_inbound_reset_next_option/nyoci_inbound_reset_next_option/g;
s/smcp_init/nyoci_init/g;
s/smcp_invalidate_timer/nyoci_invalidate_timer/g;
s/smcp_node_alloc/nyoci_node_alloc/g;
s/smcp_node_compare/nyoci_node_compare/g;
s/smcp_node_delete/nyoci_node_delete/g;
s/smcp_node_find/nyoci_node_find/g;
s/smcp_node_find_closest_with_path/nyoci_node_find_closest_with_path/g;
s/smcp_node_find_next_with_path/nyoci_node_find_next_with_path/g;
s/smcp_node_find_with_path/nyoci_node_find_with_path/g;
s/smcp_node_get_path/nyoci_node_get_path/g;
s/smcp_node_get_root/nyoci_node_get_root/g;
s/smcp_node_init/nyoci_node_init/g;
s/smcp_node_list_request_handler/nyoci_node_list_request_handler/g;
s/smcp_node_route/nyoci_node_route/g;
s/smcp_node_router_handler/nyoci_node_router_handler/g;
s/smcp_observable_clear/nyoci_observable_clear/g;
s/smcp_observable_observer_count/nyoci_observable_observer_count/g;
s/smcp_observable_trigger/nyoci_observable_trigger/g;
s/smcp_observable_update/nyoci_observable_update/g;
s/smcp_outbound_add_option/nyoci_outbound_add_option/g;
s/smcp_outbound_add_option_uint/nyoci_outbound_add_option_uint/g;
s/smcp_outbound_append_content/nyoci_outbound_append_content/g;
s/smcp_outbound_append_content_formatted/nyoci_outbound_append_content_formatted/g;
s/smcp_outbound_begin/nyoci_outbound_begin/g;
s/smcp_outbound_begin_async_response/nyoci_outbound_begin_async_response/g;
s/smcp_outbound_begin_response/nyoci_outbound_begin_response/g;
s/smcp_outbound_drop/nyoci_outbound_drop/g;
s/smcp_outbound_get_content_ptr/nyoci_outbound_get_content_ptr/g;
s/smcp_outbound_get_space_remaining/nyoci_outbound_get_space_remaining/g;
s/smcp_outbound_packet_error/nyoci_outbound_packet_error/g;
s/smcp_outbound_quick_response/nyoci_outbound_quick_response/g;
s/smcp_outbound_reset/nyoci_outbound_reset/g;
s/smcp_outbound_send/nyoci_outbound_send/g;
s/smcp_outbound_set_code/nyoci_outbound_set_code/g;
s/smcp_outbound_set_content_len/nyoci_outbound_set_content_len/g;
s/smcp_outbound_set_msg_id/nyoci_outbound_set_msg_id/g;
s/smcp_outbound_set_token/nyoci_outbound_set_token/g;
s/smcp_outbound_set_uri/nyoci_outbound_set_uri/g;
s/smcp_plat_bind_to_port/nyoci_plat_bind_to_port/g;
s/smcp_plat_bind_to_sockaddr/nyoci_plat_bind_to_sockaddr/g;
s/smcp_plat_cms_to_timestamp/nyoci_plat_cms_to_timestamp/g;
s/smcp_plat_get_fd/nyoci_plat_get_fd/g;
s/smcp_plat_get_local_sockaddr/nyoci_plat_get_local_sockaddr/g;
s/smcp_plat_get_port/nyoci_plat_get_port/g;
s/smcp_plat_get_remote_sockaddr/nyoci_plat_get_remote_sockaddr/g;
s/smcp_plat_get_session_type/nyoci_plat_get_session_type/g;
s/smcp_plat_get_udp_conn/nyoci_plat_get_udp_conn/g;
s/smcp_plat_join_standard_groups/nyoci_plat_join_standard_groups/g;
s/smcp_plat_multicast_join/nyoci_plat_multicast_join/g;
s/smcp_plat_multicast_leave/nyoci_plat_multicast_leave/g;
s/smcp_plat_process/nyoci_plat_process/g;
s/smcp_plat_set_local_sockaddr/nyoci_plat_set_local_sockaddr/g;
s/smcp_plat_set_remote_hostname_and_port/nyoci_plat_set_remote_hostname_and_port/g;
s/smcp_plat_set_remote_sockaddr/nyoci_plat_set_remote_sockaddr/g;
s/smcp_plat_set_session_type/nyoci_plat_set_session_type/g;
s/smcp_plat_timestamp_diff/nyoci_plat_timestamp_diff/g;
s/smcp_plat_timestamp_to_cms/nyoci_plat_timestamp_to_cms/g;
s/smcp_plat_tls_get_context/nyoci_plat_tls_get_context/g;
s/smcp_plat_tls_get_current_session/nyoci_plat_tls_get_current_session/g;
s/smcp_plat_tls_inbound_packet_process/nyoci_plat_tls_inbound_packet_process/g;
s/smcp_plat_tls_outbound_packet_process/nyoci_plat_tls_outbound_packet_process/g;
s/smcp_plat_tls_set_context/nyoci_plat_tls_set_context/g;
s/smcp_plat_tls_set_remote_hostname/nyoci_plat_tls_set_remote_hostname/g;
s/smcp_plat_update_fdsets/nyoci_plat_update_fdsets/g;
s/smcp_plat_update_pollfds/nyoci_plat_update_pollfds/g;
s/smcp_plat_wait/nyoci_plat_wait/g;
s/smcp_refresh_observers/nyoci_refresh_observers/g;
s/smcp_release/nyoci_release/g;
s/smcp_schedule_timer/nyoci_schedule_timer/g;
s/smcp_set_default_request_handler/nyoci_set_default_request_handler/g;
s/smcp_set_proxy_url/nyoci_set_proxy_url/g;
s/smcp_set_remote_sockaddr_from_host_and_port/nyoci_set_remote_sockaddr_from_host_and_port/g;
s/smcp_start_async_response/nyoci_start_async_response/g;
s/smcp_status_to_cstr/nyoci_status_to_cstr/g;
s/smcp_timer_init/nyoci_timer_init/g;
s/smcp_timer_is_scheduled/nyoci_timer_is_scheduled/g;
s/smcp_transaction_begin/nyoci_transaction_begin/g;
s/smcp_transaction_end/nyoci_transaction_end/g;
s/smcp_transaction_init/nyoci_transaction_init/g;
s/smcp_transaction_new_msg_id/nyoci_transaction_new_msg_id/g;
s/smcp_transaction_tickle/nyoci_transaction_tickle/g;
s/smcp_variable_handler_request_handler/nyoci_var_handler_request_handler/g;
s/smcp_vhost_add/nyoci_vhost_add/g;
s/smcp_inbound_resend_func/nyoci_inbound_resend_func/g;
s/smcp_request_handler_func/nyoci_request_handler_func/g;
s/smcp_response_handler_func/nyoci_response_handler_func/g;
s/smcp_callback_func/nyoci_callback_func/g;
s/SMCP_ADDR_NTOP/NYOCI_ADDR_NTOP/g;
s/SMCP_ADD_NEWLINES_TO_LIST_OUTPUT/NYOCI_ADD_NEWLINES_TO_LIST_OUTPUT/g;
s/SMCP_ANY_INTERFACE/NYOCI_ANY_INTERFACE/g;
s/SMCP_API_EXTERN/NYOCI_API_EXTERN/g;
s/SMCP_ASYNC_RESPONSE_FLAG_DONT_ACK/NYOCI_ASYNC_RESPONSE_FLAG_DONT_ACK/g;
s/SMCP_ASYNC_RESPONSE_MAX_LENGTH/NYOCI_ASYNC_RESPONSE_MAX_LENGTH/g;
s/SMCP_AVOID_MALLOC/NYOCI_AVOID_MALLOC/g;
s/SMCP_AVOID_PRINTF/NYOCI_AVOID_PRINTF/g;
s/SMCP_BEGIN_C_DECLS/NYOCI_BEGIN_C_DECLS/g;
s/SMCP_COAP_MULTICAST_ALLDEVICES_ADDR/NYOCI_COAP_MULTICAST_ALLDEVICES_ADDR/g;
s/SMCP_CONFIG_ID/NYOCI_CONFIG_ID/g;
s/SMCP_CONFIG_OPTIONS_HEADER/NYOCI_CONFIG_OPTIONS_HEADER/g;
s/SMCP_CONF_DEBUG_INBOUND_DROP_PERCENT/NYOCI_CONF_DEBUG_INBOUND_DROP_PERCENT/g;
s/SMCP_CONF_DEBUG_OUTBOUND_DROP_PERCENT/NYOCI_CONF_DEBUG_OUTBOUND_DROP_PERCENT/g;
s/SMCP_CONF_DUPE_BUFFER_SIZE/NYOCI_CONF_DUPE_BUFFER_SIZE/g;
s/SMCP_CONF_ENABLE_VHOSTS/NYOCI_CONF_ENABLE_VHOSTS/g;
s/SMCP_CONF_MAX_ALLOCED_NODES/NYOCI_CONF_MAX_ALLOCED_NODES/g;
s/SMCP_CONF_MAX_OBSERVERS/NYOCI_CONF_MAX_OBSERVERS/g;
s/SMCP_CONF_MAX_TIMEOUT/NYOCI_CONF_MAX_TIMEOUT/g;
s/SMCP_CONF_NODE_ROUTER/NYOCI_CONF_NODE_ROUTER/g;
s/SMCP_CONF_TRANS_ENABLE_BLOCK2/NYOCI_CONF_TRANS_ENABLE_BLOCK2/g;
s/SMCP_CONF_TRANS_ENABLE_OBSERVING/NYOCI_CONF_TRANS_ENABLE_OBSERVING/g;
s/SMCP_CONF_USE_DNS/NYOCI_CONF_USE_DNS/g;
s/SMCP_CONTENT_TYPE_APPLICATION_FORM_URLENCODED/NYOCI_CONTENT_TYPE_APPLICATION_FORM_URLENCODED/g;
s/SMCP_CSTR_LEN/NYOCI_CSTR_LEN/g;
s/SMCP_CURRENT_PATH/NYOCI_CURRENT_PATH/g;
s/SMCP_DEBUG_INBOUND_DROP_PERCENT/NYOCI_DEBUG_INBOUND_DROP_PERCENT/g;
s/SMCP_DEBUG_OUTBOUND_DROP_PERCENT/NYOCI_DEBUG_OUTBOUND_DROP_PERCENT/g;
s/SMCP_DEBUG_OUT_FILE/NYOCI_DEBUG_OUT_FILE/g;
s/SMCP_DEBUG_TIMERS/NYOCI_DEBUG_TIMERS/g;
s/SMCP_DEFAULT_PORT/NYOCI_DEFAULT_PORT/g;
s/SMCP_DEFAULT_PORT_CSTR/NYOCI_DEFAULT_PORT_CSTR/g;
s/SMCP_DEPRECATED/NYOCI_DEPRECATED/g;
s/SMCP_EMBEDDED/NYOCI_SINGLETON/g;
s/SMCP_END_C_DECLS/NYOCI_END_C_DECLS/g;
s/SMCP_FUNC_RANDOM_UINT32/NYOCI_FUNC_RANDOM_UINT32/g;
s/SMCP_GET_PATH_INCLUDE_QUERY/NYOCI_GET_PATH_INCLUDE_QUERY/g;
s/SMCP_GET_PATH_LEADING_SLASH/NYOCI_GET_PATH_LEADING_SLASH/g;
s/SMCP_GET_PATH_REMAINING/NYOCI_GET_PATH_REMAINING/g;
s/SMCP_H/NYOCI_H/g;
s/SMCP_HISTORY_FILE/NYOCI_HISTORY_FILE/g;
s/SMCP_HOOK_TIMER_NEEDS_REFRESH/NYOCI_HOOK_TIMER_NEEDS_REFRESH/g;
s/SMCP_INBOUND_PACKET_TRUNCATED/NYOCI_INBOUND_PACKET_TRUNCATED/g;
s/SMCP_INTERNAL_EXTERN/NYOCI_INTERNAL_EXTERN/g;
s/SMCP_IPPROTO/NYOCI_IPPROTO/g;
s/SMCP_IS_ADDR_LOOPBACK/NYOCI_IS_ADDR_LOOPBACK/g;
s/SMCP_IS_ADDR_MULTICAST/NYOCI_IS_ADDR_MULTICAST/g;
s/SMCP_IS_ADDR_UNSPECIFIED/NYOCI_IS_ADDR_UNSPECIFIED/g;
s/SMCP_LIBRARY_VERSION_CHECK/NYOCI_LIBRARY_VERSION_CHECK/g;
s/SMCP_LOOKUP_HOSTNAME_FLAG_DEFAULT/NYOCI_LOOKUP_HOSTNAME_FLAG_DEFAULT/g;
s/SMCP_LOOKUP_HOSTNAME_FLAG_IPV4_ONLY/NYOCI_LOOKUP_HOSTNAME_FLAG_IPV4_ONLY/g;
s/SMCP_LOOKUP_HOSTNAME_FLAG_IPV6_ONLY/NYOCI_LOOKUP_HOSTNAME_FLAG_IPV6_ONLY/g;
s/SMCP_LOOKUP_HOSTNAME_FLAG_NUMERIC/NYOCI_LOOKUP_HOSTNAME_FLAG_NUMERIC/g;
s/SMCP_MAX_CASCADE_COUNT/NYOCI_MAX_CASCADE_COUNT/g;
s/SMCP_MAX_CONTENT_LENGTH/NYOCI_MAX_CONTENT_LENGTH/g;
s/SMCP_MAX_OBSERVERS/NYOCI_MAX_OBSERVERS/g;
s/SMCP_MAX_PACKET_LENGTH/NYOCI_MAX_PACKET_LENGTH/g;
s/SMCP_MAX_PATH_LENGTH/NYOCI_MAX_PATH_LENGTH/g;
s/SMCP_MAX_TIMEOUT/NYOCI_MAX_TIMEOUT/g;
s/SMCP_MAX_URI_LENGTH/NYOCI_MAX_URI_LENGTH/g;
s/SMCP_MAX_VHOSTS/NYOCI_MAX_VHOSTS/g;
s/SMCP_MSG_SKIP_AUTHORITY/NYOCI_MSG_SKIP_AUTHORITY/g;
s/SMCP_MSG_SKIP_DESTADDR/NYOCI_MSG_SKIP_DESTADDR/g;
s/SMCP_MSG_SKIP_PATH/NYOCI_MSG_SKIP_PATH/g;
s/SMCP_MSG_SKIP_QUERY/NYOCI_MSG_SKIP_QUERY/g;
s/SMCP_NODE_ROUTER_USE_BTREE/NYOCI_NODE_ROUTER_USE_BTREE/g;
s/SMCP_NON_RECURSIVE/NYOCI_NON_RECURSIVE/g;
s/SMCP_OBSERVABLE_BROADCAST_KEY/NYOCI_OBSERVABLE_BROADCAST_KEY/g;
s/SMCP_OBSERVATION_DEFAULT_MAX_AGE/NYOCI_OBSERVATION_DEFAULT_MAX_AGE/g;
s/SMCP_OBSERVATION_KEEPALIVE_INTERVAL/NYOCI_OBSERVATION_KEEPALIVE_INTERVAL/g;
s/SMCP_OBSERVER_CON_EVENT_EXPIRATION/NYOCI_OBSERVER_CON_EVENT_EXPIRATION/g;
s/SMCP_OBSERVER_NON_EVENT_EXPIRATION/NYOCI_OBSERVER_NON_EVENT_EXPIRATION/g;
s/SMCP_OBS_TRIGGER_FLAG_FORCE_CON/NYOCI_OBS_TRIGGER_FLAG_FORCE_CON/g;
s/SMCP_OBS_TRIGGER_FLAG_NO_INCREMENT/NYOCI_OBS_TRIGGER_FLAG_NO_INCREMENT/g;
s/SMCP_PKTINFO/NYOCI_PKTINFO/g;
s/SMCP_PLAT_HEADER_INCLUDED/NYOCI_PLAT_HEADER_INCLUDED/g;
s/SMCP_PLAT_NET/NYOCI_PLAT_NET/g;
s/SMCP_BSD_SOCKETS_NET_FAMILY/NYOCI_PLAT_NET_POSIX_FAMILY/g;
s/SMCP_PLAT_TLS/NYOCI_PLAT_TLS/g;
s/SMCP_PLAT_TLS_DEFAULT_CONTEXT/NYOCI_PLAT_TLS_DEFAULT_CONTEXT/g;
s/SMCP_PLAT_TLS_OPENSSL/NYOCI_PLAT_TLS_OPENSSL/g;
s/SMCP_PURE_FUNC/NYOCI_PURE_FUNC/g;
s/SMCP_RANDOM_MAX/NYOCI_RANDOM_MAX/g;
s/SMCP_RECVPKTINFO/NYOCI_RECVPKTINFO/g;
s/SMCP_SESSION_TYPE_DTLS/NYOCI_SESSION_TYPE_DTLS/g;
s/SMCP_SESSION_TYPE_FLAG_MULTICAST/NYOCI_SESSION_TYPE_FLAG_MULTICAST/g;
s/SMCP_SESSION_TYPE_FLAG_RELIABLE/NYOCI_SESSION_TYPE_FLAG_RELIABLE/g;
s/SMCP_SESSION_TYPE_FLAG_SECURE/NYOCI_SESSION_TYPE_FLAG_SECURE/g;
s/SMCP_SESSION_TYPE_NIL/NYOCI_SESSION_TYPE_NIL/g;
s/SMCP_SESSION_TYPE_TCP/NYOCI_SESSION_TYPE_TCP/g;
s/SMCP_SESSION_TYPE_TLS/NYOCI_SESSION_TYPE_TLS/g;
s/SMCP_SESSION_TYPE_UDP/NYOCI_SESSION_TYPE_UDP/g;
s/SMCP_SINGLETON/NYOCI_SINGLETON/g;
s/SMCP_SINGLETON_SELF_HOOK/NYOCI_SINGLETON_SELF_HOOK/g;
s/SMCP_STATUS_ASYNC_RESPONSE/NYOCI_STATUS_ASYNC_RESPONSE/g;
s/SMCP_STATUS_BAD_ARGUMENT/NYOCI_STATUS_BAD_ARGUMENT/g;
s/SMCP_STATUS_BAD_HOSTNAME/NYOCI_STATUS_BAD_HOSTNAME/g;
s/SMCP_STATUS_BAD_OPTION/NYOCI_STATUS_BAD_OPTION/g;
s/SMCP_STATUS_BAD_PACKET/NYOCI_STATUS_BAD_PACKET/g;
s/SMCP_STATUS_CASCADE_LOOP/NYOCI_STATUS_CASCADE_LOOP/g;
s/SMCP_STATUS_DUPE/NYOCI_STATUS_DUPE/g;
s/SMCP_STATUS_ERRNO/NYOCI_STATUS_ERRNO/g;
s/SMCP_STATUS_FAILURE/NYOCI_STATUS_FAILURE/g;
s/SMCP_STATUS_HEADER_INCLUDED/NYOCI_STATUS_HEADER_INCLUDED/g;
s/SMCP_STATUS_HOST_LOOKUP_FAILURE/NYOCI_STATUS_HOST_LOOKUP_FAILURE/g;
s/SMCP_STATUS_H_ERRNO/NYOCI_STATUS_H_ERRNO/g;
s/SMCP_STATUS_INVALIDATE/NYOCI_STATUS_INVALIDATE/g;
s/SMCP_STATUS_INVALID_ARGUMENT/NYOCI_STATUS_INVALID_ARGUMENT/g;
s/SMCP_STATUS_LOOP_DETECTED/NYOCI_STATUS_LOOP_DETECTED/g;
s/SMCP_STATUS_MALLOC_FAILURE/NYOCI_STATUS_MALLOC_FAILURE/g;
s/SMCP_STATUS_MESSAGE_TOO_BIG/NYOCI_STATUS_MESSAGE_TOO_BIG/g;
s/SMCP_STATUS_MULTICAST_NOT_SUPPORTED/NYOCI_STATUS_MULTICAST_NOT_SUPPORTED/g;
s/SMCP_STATUS_NOT_ALLOWED/NYOCI_STATUS_NOT_ALLOWED/g;
s/SMCP_STATUS_NOT_FOUND/NYOCI_STATUS_NOT_FOUND/g;
s/SMCP_STATUS_NOT_IMPLEMENTED/NYOCI_STATUS_NOT_IMPLEMENTED/g;
s/SMCP_STATUS_OK/NYOCI_STATUS_OK/g;
s/SMCP_STATUS_OUT_OF_SESSIONS/NYOCI_STATUS_OUT_OF_SESSIONS/g;
s/SMCP_STATUS_RESET/NYOCI_STATUS_RESET/g;
s/SMCP_STATUS_RESPONSE_NOT_ALLOWED/NYOCI_STATUS_RESPONSE_NOT_ALLOWED/g;
s/SMCP_STATUS_SESSION_CLOSED/NYOCI_STATUS_SESSION_CLOSED/g;
s/SMCP_STATUS_SESSION_ERROR/NYOCI_STATUS_SESSION_ERROR/g;
s/SMCP_STATUS_STOP_RESENDING/NYOCI_STATUS_STOP_RESENDING/g;
s/SMCP_STATUS_TIMEOUT/NYOCI_STATUS_TIMEOUT/g;
s/SMCP_STATUS_TRANSACTION_INVALIDATED/NYOCI_STATUS_TRANSACTION_INVALIDATED/g;
s/SMCP_STATUS_UNAUTHORIZED/NYOCI_STATUS_UNAUTHORIZED/g;
s/SMCP_STATUS_UNSUPPORTED_MEDIA_TYPE/NYOCI_STATUS_UNSUPPORTED_MEDIA_TYPE/g;
s/SMCP_STATUS_UNSUPPORTED_URI/NYOCI_STATUS_UNSUPPORTED_URI/g;
s/SMCP_STATUS_URI_PARSE_FAILURE/NYOCI_STATUS_URI_PARSE_FAILURE/g;
s/SMCP_STATUS_WAIT_FOR_DNS/NYOCI_STATUS_WAIT_FOR_DNS/g;
s/SMCP_STATUS_WAIT_FOR_SESSION/NYOCI_STATUS_WAIT_FOR_SESSION/g;
s/SMCP_THREAD_SAFE/NYOCI_THREAD_SAFE/g;
s/SMCP_TRANSACTIONS_USE_BTREE/NYOCI_TRANSACTIONS_USE_BTREE/g;
s/SMCP_TRANSACTION_ALWAYS_INVALIDATE/NYOCI_TRANSACTION_ALWAYS_INVALIDATE/g;
s/SMCP_TRANSACTION_BURST/NYOCI_TRANSACTION_BURST/g;
s/SMCP_TRANSACTION_BURST_COUNT/NYOCI_TRANSACTION_BURST_COUNT/g;
s/SMCP_TRANSACTION_BURST_MULTICAST/NYOCI_TRANSACTION_BURST_MULTICAST/g;
s/SMCP_TRANSACTION_BURST_TIMEOUT_MAX/NYOCI_TRANSACTION_BURST_TIMEOUT_MAX/g;
s/SMCP_TRANSACTION_BURST_TIMEOUT_MIN/NYOCI_TRANSACTION_BURST_TIMEOUT_MIN/g;
s/SMCP_TRANSACTION_BURST_UNICAST/NYOCI_TRANSACTION_BURST_UNICAST/g;
s/SMCP_TRANSACTION_DELAY_START/NYOCI_TRANSACTION_DELAY_START/g;
s/SMCP_TRANSACTION_KEEPALIVE/NYOCI_TRANSACTION_KEEPALIVE/g;
s/SMCP_TRANSACTION_MAX_ATTEMPTS/NYOCI_TRANSACTION_MAX_ATTEMPTS/g;
s/SMCP_TRANSACTION_NO_AUTO_END/NYOCI_TRANSACTION_NO_AUTO_END/g;
s/SMCP_TRANSACTION_OBSERVE/NYOCI_TRANSACTION_OBSERVE/g;
s/SMCP_TRANSACTION_POOL_SIZE/NYOCI_TRANSACTION_POOL_SIZE/g;
s/SMCP_USE_BSD_SOCKETS/NYOCI_USE_BSD_SOCKETS/g;
s/SMCP_USE_CASCADE_COUNT/NYOCI_USE_CASCADE_COUNT/g;
s/SMCP_VARIABLE_MAX_KEY_LENGTH/NYOCI_VARIABLE_MAX_KEY_LENGTH/g;
s/SMCP_VARIABLE_MAX_VALUE_LENGTH/NYOCI_VARIABLE_MAX_VALUE_LENGTH/g;
s/SMCP_VAR_CHECK_KEY/NYOCI_VAR_CHECK_KEY/g;
s/SMCP_VAR_GET_ETAG/NYOCI_VAR_GET_ETAG/g;
s/SMCP_VAR_GET_KEY/NYOCI_VAR_GET_KEY/g;
s/SMCP_VAR_GET_LF_TITLE/NYOCI_VAR_GET_LF_TITLE/g;
s/SMCP_VAR_GET_MAX_AGE/NYOCI_VAR_GET_MAX_AGE/g;
s/SMCP_VAR_GET_OBSERVABLE/NYOCI_VAR_GET_OBSERVABLE/g;
s/SMCP_VAR_GET_VALUE/NYOCI_VAR_GET_VALUE/g;
s/SMCP_VAR_SET_VALUE/NYOCI_VAR_SET_VALUE/g;
s/smcp_addr_t/nyoci_addr_t/g;
s/smcp_async_response_s/nyoci_async_response_s/g;
s/smcp_async_response_t/nyoci_async_response_t/g;
s/smcp_cms_t/nyoci_cms_t/g;
s/smcp_dupe_info_s/nyoci_dupe_info_s/g;
s/smcp_node_s/nyoci_node_s/g;
s/smcp_node_t/nyoci_node_t/g;
s/smcp_observable_s/nyoci_observable_s/g;
s/smcp_observable_t/nyoci_observable_t/g;
s/smcp_observer_s/nyoci_observer_s/g;
s/smcp_openssl_session_s/nyoci_openssl_session_s/g;
s/smcp_plat_s/nyoci_plat_s/g;
s/smcp_plat_ssl_s/nyoci_plat_tls_s/g;
s/smcp_session_s/nyoci_session_s/g;
s/smcp_session_type_t/nyoci_session_type_t/g;
s/smcp_sockaddr_t/nyoci_sockaddr_t/g;
s/smcp_status_t/nyoci_status_t/g;
s/smcp_timer_callback_t/nyoci_timer_callback_t/g;
s/smcp_timer_s/nyoci_timer_s/g;
s/smcp_timer_t/nyoci_timer_t/g;
s/smcp_timestamp_t/nyoci_timestamp_t/g;
s/smcp_transaction_s/nyoci_transaction_s/g;
s/smcp_transaction_t/nyoci_transaction_t/g;
s/smcp_variable_handler_s/nyoci_var_handler_s/g;
s/smcp_variable_handler_t/nyoci_var_handler_t/g;
s/smcp_vhost_s/nyoci_vhost_s/g;
s/smcp_t/nyoci_t/g;
s/smcp_instance/nyoci_instance/g;
s/smcp_addr/nyoci_addr/g;
s/smcp_port/nyoci_port/g;
s/smcp_plat_lookup_hostname/nyoci_plat_lookup_hostname/g;
s/SMCP_SOCKADDR_INIT/NYOCI_SOCKADDR_INIT/g;
