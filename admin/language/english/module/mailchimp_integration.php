<?php
//==============================================================================
// MailChimp Integration v155.7
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

$version = 'v155.7';

// Heading
$_['heading_title']				= 'MailChimp Integration';

// Buttons
$_['button_save_exit']			= 'Save & Exit';
$_['button_save_keep_editing']	= 'Save & Keep Editing';
$_['button_sync']				= 'Sync';

// General Settings
$_['entry_general_settings']	= 'General Settings';
$_['help_general_settings']		= '<span class="help"><ul style="margin: -5px 0 0"><li>If the Status is set to "Enabled", the MailChimp Integration will automatically sync customers between OpenCart and MailChimp when customers create or edit their account in the front-end, and administrators create, edit, or delete customers in the back-end.</li><li>If enabled below, double opt-in (confirmation) e-mails will be sent for customer-initiated changes, but will NEVER be sent for administrator-initiated changes. It is assumed that admins have the customer\'s permission to make any changes to their MailChimp profile information.</li></ul></span>';
$_['entry_api_key']				= 'API Key:<span class="help">You can find your API Key in MailChimp under:<br />Account > API Keys & Authorized Apps</span>';
$_['entry_default_list']		= 'Default List:<span class="help">Select the default mailing list used if not specified for a store + customer group combination below.</span>';
$_['text_enter_an_api_key']		= 'Enter an API Key and click "Save" to automatically pull your MailChimp Lists';
$_['entry_newsletter_status']	= 'Newsletter Status Mapping:<span class="help">If desired, select a different customer group to which the customer is changed when subscribed or unsubscribed from your OpenCart newsletter. Note that this customer group change will occur BEFORE the "List Mapping" is executed.</span>';
$_['text_subscribed_customers']	= 'Subscribed Customers:';
$_['text_unsubscribed_customers']	= 'Unsubscribed Customers:';
$_['text_no_change']			= '--- No Change ---';
$_['entry_list_mapping']		= 'List Mapping:<span class="help">If desired, select a different mailing list for any store + customer group combination. If no mapping is specified, the default list will be used.<br /><br />If you have webhooks enabled and are auto-creating customers, the webhook\'s List ID will be compared against the default store\'s customer groups when creating new customers.</span>';
$_['text_not_logged_in']		= '<em>Customers Not Logged In</em>';
$_['text_default_list']			= '--- Default List ---';
$_['entry_autocreate']			= 'Auto-Create Customers:<span class="help">If set to "Yes" and an e-mail exists in MailChimp but not OpenCart, a new customer will be created for that e-mail, with a random password.</span>';
$_['text_yes_enabled']			= 'Yes, enabled by default';
$_['text_yes_disabled']			= 'Yes, disabled by default';
$_['entry_double_optin']		= 'Double Opt-In Confirmation E-mails:<span class="help">Unless you collect confirmation information yourself, it is <strong>NOT</strong> recommended to disable this. <a target="_blank" href="http://kb.mailchimp.com/article/how-does-confirmed-optin-or-double-optin-work">Read why</a></span>';
$_['entry_log_errors_and']		= 'Log Errors and Webhooks:';

// Merge Tags
$_['entry_merge_tags']			= 'Merge Tags';
$_['help_merge_tags']			= '<span class="help"><ul style="margin: -5px 0 0"><li>You can find your MailChimp List\'s merge tags under Lists > Settings > Fields and Merge Tags. If you don\'t use one of the following merge tags, leave it blank.</li><li>The customer\'s MailChimp language (i.e. MC_LANGUAGE merge tag value) will attempt to be set using the customer\'s browser language, but if this fails, you can also set the default language value below.</li></ul></span>';
$_['entry_fname_merge_tag']		= 'First Name Merge Tag:';
$_['entry_lname_merge_tag']		= 'Last Name Merge Tag:';
$_['entry_address_merge_tag']	= 'Address Merge Tag:';
$_['entry_phone_merge_tag']		= 'Phone Number Merge Tag:';
$_['entry_default_language']	= 'Default Customer Language:';

// Webhook Settings
$_['entry_webhook_settings']	= 'Webhook Settings';
$_['entry_webhooks']			= 'Webhooks:<span class="help">Select the type of actions that cause MailChimp to send information back to OpenCart. Note that Profile Updates can change the customer\'s log-in e-mail address, name, phone number, and default address, so use with caution.</span>';
$_['text_subscribes']			= 'Subscribes';
$_['text_unsubscribes']			= 'Unsubscribes';
$_['text_profile_updates']		= 'Profile/Email Updates';
$_['text_cleaned_addresses']	= 'Cleaned Addresses';
$_['entry_url_code']			= 'URL Code:<span class="help">For security purposes, enter a secret code to be appended to the MailChimp webhook URL, which will be automatically sent to MailChimp. Only letters, numbers, and underscores are allowed.</span>';

// Manual Sync
$_['entry_manual_sync']			= 'Manual Sync';
$_['help_manual_sync']			= '<span class="help"><ul style="margin: -5px 0 0"><li>You should only need to manually sync once, when you first install this extension. After that, all syncing should happen automatically in the background.</li><li>Confirmation e-mails are NOT sent when manually syncing, so be sure to have approval from your customers to add them to your mailing list.</li><li>If an e-mail exists in both OpenCart and MailChimp, the information associated with it in OpenCart will be used for the sync.</li></span>';
$_['entry_sync_opencart']		= 'Sync OpenCart & MailChimp:';
$_['text_sync_error']			= 'Sync Error: The API Key and List ID fields must be filled in before syncing!';
$_['text_sync_note']			= 'Note: If you have a lot of customers, this may take some time. Continue?';
$_['text_syncing']				= 'Syncing...';

// Modules
$_['entry_modules']				= 'Module(s)';
$_['help_modules']				= '<span class="help"><ul style="margin: -5px 0 0"><li><strong>Status:</strong> A red X means Disabled and a green checkmark means Enabled. Click to toggle the setting.</li><li><strong>Display as Pop-up:</strong> If set to "Yes", the module box will be hidden and require a link to be clicked. You need to add this link yourself to a template file, in this format:<br /><span style="font-family: monospace">&lt;a class="mailchimp-popup" href=".mailchimp-integration .box-content"&gt;LINK TEXT&lt;/a&gt;</span><li><strong>Name Field:</strong> Select whether a name field is present in the module, and whether it is optional or required.</li><li><strong>Redirect URL:</strong> Optionally enter a URL to redirect the customer to after they are successfully subscribed. Leave blank to have them stay on the same page.</li></span>';
$_['entry_status']				= 'Status';
$_['entry_options']				= 'Options';
$_['text_display_as_popup']		= 'Display as Pop-up:';
$_['text_name_field']			= 'Name Field:';
$_['text_none']					= 'None';
$_['text_optional']				= 'Optional';
$_['text_required']				= 'Required';
$_['text_redirect_url']			= 'Redirect URL:';
$_['entry_layout']				= 'Layout';
$_['entry_position']			= 'Position';
$_['entry_sort_order']			= 'Sort Order';

// Copyright
$_['copyright']					= '<div style="text-align: center" class="help">' . $_['heading_title'] . ' ' . $version . ' &copy; <a target="_blank" href="http://www.getclearthinking.com">Clear Thinking, LLC</a></div>';

// Standard Text
$_['text_left']					= 'Left';
$_['text_right']				= 'Right';
$_['text_content_top']			= 'Content Top';
$_['text_content_bottom']		= 'Content Bottom';
$_['text_column_left']			= 'Column Left';
$_['text_column_right']			= 'Column Right';
$_['standard_module']			= 'Modules';
$_['standard_shipping']			= 'Shipping';
$_['standard_payment']			= 'Payments';
$_['standard_total']			= 'Order Totals';
$_['standard_feed']				= 'Product Feeds';
$_['standard_success']			= 'Success: You have modified ' . $_['heading_title'] . '!';
$_['standard_error']			= 'Warning: You do not have permission to modify ' . $_['heading_title'] . '!';
?>