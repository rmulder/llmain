/**
 * AL.Constants.js - Project relative constants.
 *
 * All constant names must be in upper case, use underscore to split words.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * Developers:
 *     Tan Nhu - initial API and implementation
 *
 */
(function() {
	// Keys
	/**
	 * @constant
	 * @name AL.ENTER_KEY
	 */
	AL.ENTER_KEY = 13;

	/**
	 * @constant
	 * @name AL.TAB_KEY
	 */
	AL.TAB_KEY = 9;

	/**
	 * @constant
	 * @name AL.DELETE_KEY
	 */
	AL.DELETE_KEY = 46;

	/**
	 * @constant
	 * @name AL.BACKSPACE
	 */
	AL.BACKSPACE = 8;

	// Return codes
	/**
	 * @constant
	 * @name AL.SUCCESS
	 */
	AL.SUCCESS = 'success';

	/**
	 * @constant
	 * @name AL.FAILURE
	 */
	AL.FAILURE = 'failure';

	/**
	 * @constant
	 * @name AL.EVENT_LOG_BUSINESS_IMPRESSION
	 */
	AL.EVENT_LOG_BUSINESS_IMPRESSION = 12;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_BUSINESS_CLICKTHU
	 */
	AL.EVENT_LOG_BUSINESS_CLICKTHU = 13;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_OFFER_IMPRESSION
	 */
	AL.EVENT_LOG_OFFER_IMPRESSION = 10;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_OFFER_CLICKTHRU
	 */
	AL.EVENT_LOG_OFFER_CLICKTHRU = 11;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_WEBSITE_CLICKTHRU
	 */
	AL.EVENT_LOG_WEBSITE_CLICKTHRU = 2;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_SMB_PROMO_IMPRESSION
	 */
	AL.EVENT_LOG_SMB_PROMO_IMPRESSION = 15;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_SMB_PROMO_IMPRESSION
	 */
	AL.EVENT_LOG_SMB_PROMO_GET_STARTED = 16;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_SMB_PROMO_IMPRESSION
	 */
	AL.EVENT_LOG_SMB_PROMO_REGISTER = 17;

	/**
	 * @constant
	 * @name AL.EVENT_LOG_SMB_PROMO_IMPRESSION
	 */
	AL.EVENT_LOG_SMB_PROMO_CLAIM = 18;

	// After duration, auto hide error message
	AL.ERROR_AUTO_HIDE_DURATION = 25000;

	// Infinity duration
	AL.INFINITY = 999999999;

	// Warnings / Errors
	AL.ERROR_NO_CUSTOM_LISTS = 'You have no custom lists. Please create one below or in the navigation bar on the left side of the screen.';

	// City auto complete url
	AL.CITY_AUTO_COMPLETE_URL = '/ajax/list_city';

	// Check city url
	AL.CHECK_CITY_URL = '/ajax/check_city';

	// Business auto complete url
	AL.BUSINESS_AUTO_COMPLETE_URL = '/ajax/business_name_suggest';
	AL.BUSINESS_AUTO_COMPLETE_PROMPT = 'Start typing to select a category from the list';

	// Default avatar url (for all users don't upload an avatar)
	AL.DEFAULT_AVATAR_URL = '/images/no_photo.gif';

	// home pages
	AL.OFFER_ROTATION_NUM = 5; // show only 5 offers at a time
	AL.OFFER_ROTATION_SPEED = 7 * 1000;
	AL.HOME_FLASH_VID_URL = '/images/beta2/homepromo/homevid_new'; // homevid_new.swf must be copied to the correct location if this constant is changed

	AL.MYLIST_FLASH_VID_URL = '/images/beta2/homepromo/homevid'; // homevid.swf must be copied to the correct location if this constant is changed

	// Dynamic popup template
	AL.DYNAMIC_TEMPLATE_URL = '/pages/template/dynamicPopup';
	AL.DYNAMIC_TEMPLATE_ID = 'dynamic-popup-container';

	// BusinessCategory
	if (window.MAIN_CATEGORIES) { // prevent from pausing on try/catch in firebug
		try {
			AL.BIZ_ROOT_CAT = MAIN_CATEGORIES; // Depend on backend code, in some places MAIN_CATEGORIES does not exist
		} catch (error){}
	}
	AL.BIZ_CATEGORY_TEMPLATE_ID = 'biz-category-container';
	AL.BIZ_CATEGORY_TEMPLATE_URL = '/pages/template/businessCategory';
	AL.BIZ_CATEGORY_URL = '/ajax/get_business_types';

	// ContactPopup
	AL.CONTACT_POPUP_TEMPLATE_ID = 'contact-popup-container';
	AL.CONTACT_POPUP_TEMPLATE_URL = '/pages/template/contactPopup';

	// MembersLikePopup
	AL.MEMBERS_LIKE_POPUP_TEMPLATE_ID = 'members-like-popup-container';
	AL.MEMBERS_LIKE_POPUP_TEMPLATE_URL = '/pages/template/membersLikePopup';
	AL.MEMBERS_LIKE_POPUP_MAX_COMMENTS = 4;

	// SharePopup
	AL.SHARE_POPUP_ID = 'share-popup';
	AL.SHARE_POPUP_ELEMENTS_ID = 'share-popup-elements';
	AL.SHARE_POPUP_ELEMENTS_URL = '/pages/template/sharePopup';
	AL.SHARE_POPUP_GET_FRIENDS_URL = '/js/test/resources/sharePopup-friends-json.js'; // Entry point to get Friends information
	AL.SHARE_POPUP_SUBMIT_URL = '/ajax/share_it';

	// TryPopup *** deprecated in favor of 'AddCommentPopup'
	AL.TRY_POPUP_TEMPLATE_ID = 'try-popup-container';
	AL.TRY_POPUP_TEMPLATE_URL = '/pages/template/tryPopup';
	AL.TRY_POPUP_TEMPLATE_LOADING_ID = 'try-popup-ajax-indicator';
	AL.TRY_POPUP_GET_LISTS_URL = '/lists/get_lists_json';
	AL.TRY_POPUP_SUBMIT_URL = '/lists/add_business';

	// LikePopup *** deprecated in favor of 'AddCommentPopup'
	AL.LIKE_POPUP_ID = 'like-popup';
	AL.LIKE_POPUP_ELEMENTS_ID = 'like-popup-elements';
	AL.LIKE_POPUP_ELEMENTS_URL = '/pages/template/likePopup';
	AL.LIKE_POPUP_GET_LISTS_URL = '/lists/get_lists_for_bid_json';
	AL.LIKE_POPUP_SUBMIT_URL = '/lists/add_business';
	AL.LIKE_POPUP_SUBMIT_CUSTOM_LIST_URL = '/lists/save_business_lists';

	// DragdropCommentPopup
	AL.DRAGDROP_COMMENT_POPUP_ID = 'dragdrop-comment-popup';
	AL.DRAGDROP_COMMENT_POPUP_ELEMENTS_ID = 'dragdrop-comment-popup-elements';
	AL.DRAGDROP_COMMENT_POPUP_ELEMENTS_URL = '/pages/template/dragdropCommentPopup';

	// EditCommentPopup *** deprecated in favor of 'AddCommentPopup'
	AL.EDIT_COMMENT_POPUP_TEMPLATE_ID = 'edit-comment-popup-container';
	AL.EDIT_COMMENT_POPUP_TEMPLATE_URL = '/pages/template/editCommentPopup';
	AL.EDIT_COMMENT_POPUP_SUBMIT_URL = '/ajax/edit_comment';
	AL.EDIT_COMMENT_POPUP_FRAME_CLASS = 'flike';

	//
	// AddCommentPopup - used in listing actions 'like it' and 'liked'
	//
	/**
	 * Popup container id
	 * @const
	 * @name AL.ADD_COMMENT_POPUP_ID
	 */
	AL.ADD_COMMENT_POPUP_ID = 'add-comment-popup';
	/**
	 * Popup elements id
	 * @const
	 * @name AL.ADD_COMMENT_POPUP_ELEMENTS_ID
	 */
	AL.ADD_COMMENT_POPUP_ELEMENTS_ID = 'add-comment-popup-elements';
	/**
	 * Location of the template
	 * @const
	 * @name AL.ADD_COMMENT_POPUP_ELEMENTS_URL
	 */
	AL.ADD_COMMENT_POPUP_ELEMENTS_URL = '/pages/template/addCommentPopup';
	/**
	 * URL used to submit the new data
	 * @const
	 * @name AL.ADD_COMMENT_POPUP_SUBMIT_URL
	 */
	AL.ADD_COMMENT_POPUP_SUBMIT_URL = '/lists/add_business';
	/**
	 * URL used to submit the edited comment
	 * @const
	 * @name AL.ADD_COMMENT_POPUP_EDIT_URL
	 */
	AL.ADD_COMMENT_POPUP_EDIT_URL = '/ajax/edit_comment';

	//
	// LikeContextPopup
	//
	/**
	 * Id for like context dynamic popup
	 * @const
	 * @name AL.LIKE_CONTEXT_POPUP_ID
	 */
	AL.LIKE_CONTEXT_POPUP_ID = 'like-context-popup';
	/**
	 * Share element selector
	 * @const
	 * @name AL.LIKE_CONTEXT_ELEMENTS_ID
	 */
	AL.LIKE_CONTEXT_ELEMENTS_ID = 'like-context-element';
	/**
	 * Share element location
	 * @const
	 * @name AL.LIKE_CONTEXT_ELEMENTS_URL
	 */
	AL.LIKE_CONTEXT_ELEMENTS_URL = '/pages/template/likeContextElement';
	/**
	 * Custom lists element selector
	 * @const
	 * @name AL.CUSTOM_LIST_ELEMENTS_ID
	 */
	AL.CUSTOM_LIST_ELEMENTS_ID = 'custom-lists-element';
	/**
	 * Custom lists element location
	 * @const
	 * @name AL.CUSTOM_LIST_ELEMENTS_URL
	 */
	AL.CUSTOM_LIST_ELEMENTS_URL = '/pages/template/customListsElement';

	/**
	 * Get city id from its name.
	 */
	AL.GET_CITY_ID_URL = '/ajax/get_city_id/';
	
	//
	// ListsPopup
	//
	AL.LISTS_POPUP_TEMPLATE_ID = 'lists-popup-container';
	AL.LISTS_POPUP_TEMPLATE_URL = '/pages/template/listsPopup';
	AL.LISTS_POPUP_GET_LISTS_URL = '/lists/get_lists_for_bid';
	AL.LISTS_POPUP_SUBMIT_URL = '/lists/save_business_lists';
	AL.LISTS_POPUP_FRAME_CLASS = 'flike';

	// RemoveListingPopup
	AL.REMOVE_LISTING_POPUP_TEMPLATE_ID = 'remove-popup-container';
	AL.REMOVE_LISTING_POPUP_TEMPLATE_URL = '/pages/template/removePopup';
	AL.REMOVE_LISTING_POPUP_SUBMIT_URL = '/lists/remove_business'; // business_id/listType
	AL.REMOVE_LISTING_POPUP_SUBMIT_CUSTOM_URL = '/lists/delete_item_by_business_id'; // c_list/business_id/listType
	AL.REMOVE_LISTING_POPUP_FRAME_CLASS = 'flike';
	AL.REMOVE_LISTING_POPUP_TITLE = 'Unlike';
	AL.REMOVE_LISTING_POPUP_CUSTOM_LIST_MESSAGE = "Are you sure you want to remove this business from list '<<list>>'?";
	AL.REMOVE_LISTING_POPUP_GLOBAL_MESSAGE = 'Are you sure you want to unlike this business? This will remove the business from all your lists and delete your comments.';

	// LoginPopup
	AL.LOGIN_POPUP_TEMPLATE_ID = 'login-popup-container';
	AL.LOGIN_POPUP_TEMPLATE_URL = '/pages/template/loginPopup';
	AL.LOGIN_POPUP_SUBMIT_URL = '/login';
	AL.LOGIN_POPUP_SUBMIT_FORGOT_URL = '/login/forgotpassword';
	AL.LOGIN_POPUP_DEFAULT_REDIRECT = '/';
	AL.LOGIN_POPUP_COOKIE_ERROR = 'Cookies are not enabled on your browser. Please adjust this in your security preferences before continuing.';
	AL.LOGIN_POPUP_HIDDEN_PASS = 'hiddenPass';
	AL.LOGIN_POPUP_FORGOT_DEFAULT_MSG = "We'll send you a message with a temporary password. You can then reset it in your account settings.";

	// LocationPopup
	AL.LOCATION_POPUP_TEMPLATE_ID = 'location-popup-container';
	AL.LOCATION_POPUP_TEMPLATE_URL = '/pages/template/locationPopup';

	// GenericFilterPopup
	AL.GENERIC_FILTER_POPUP_TEMPLATE_ID = 'generic-filter-popup-container';
	AL.GENERIC_FILTER_POPUP_TEMPLATE_URL = '/pages/template/genericFilterPopup';

	// ResultsNarrowByPopup
	AL.RESULT_NARROW_BY_POPUP_TEMPLATE_ID = 'results-narrow-by-popup-container';
	AL.RESULT_NARROW_BY_POPUP_TEMPLATE_URL = '/pages/template/resultsNarrowByPopup';

	// MemberPopup
	AL.MEMBER_POPUP_TEMPLATE_ID = 'member-popup-container';
	AL.MEMBER_POPUP_TEMPLATE_URL = '/pages/template/memberPopup';
	AL.MEMBER_POPUP_SEND_INVITE_URL = '/ajax/sendInvites';
	AL.MEMBER_POPUP_SEND_ASK_URL = '/ajax/sendAsks';
	AL.MEMBER_POPUP_REMOVE_FRIEND_URL = '/ajax/friend_remove';
	AL.MEMBER_POPUP_INFO_URL = '/ajax/member_info_json';

	AL.MEMBER_POPUP_INVITE_SUBJECT = 'Check out LikeList - a new way to find local businesses!'; // we should change this!
	AL.MEMBER_POPUP_ERROR_INPUT_WHAT = 'Please enter what are you looking for';
	AL.MEMBER_POPUP_ERROR_INPUT_WHERE = 'Please enter a location';

	// RemoveCustomListPopup
	AL.REMOVE_CUSTOM_LIST_POPUP_TEMPLATE_ID = 'remove-popup-container';
	AL.REMOVE_CUSTOM_LIST_POPUP_TEMPLATE_URL = '/pages/template/removePopup';
	AL.REMOVE_CUSTOM_LIST_POPUP_SUBMIT_URL = '/lists/delete_list';
	AL.REMOVE_CUSTOM_LIST_POPUP_TITLE = "Delete '<<title>>'";
	AL.REMOVE_CUSTOM_LIST_POPUP_MESSAGE = 'Are you sure you want to delete this custom list? This will not affect your Like or Try lists.';

	// EditCustomListPopup
	AL.EDIT_CUSTOM_LIST_POPUP_TEMPLATE_ID = 'edit-custom-list-popup-container';
	AL.EDIT_CUSTOM_LIST_POPUP_TEMPLATE_URL = '/pages/template/editCustomListPopup';
	AL.EDIT_CUSTOM_LIST_POPUP_SUBMIT_URL = '/lists/rename_list';
	AL.EDIT_CUSTOM_LIST_POPUP_TITLE = "Edit '<<title>>'";

	// CreateCustomListPopup
	AL.CREATE_CUSTOM_LIST_POPUP_ID = 'create-custom-list-popup';
	AL.CREATE_CUSTOM_LIST_POPUP_ELEMENTS_ID = 'create-custom-list-popup-elements';
	AL.CREATE_CUSTOM_LIST_POPUP_ELEMENTS_URL = '/pages/template/createCustomListPopup';
	AL.CREATE_CUSTOM_LIST_POPUP_SUBMIT_URL = '/lists/create_list';
	AL.CUSTOM_LIST_DESC_CHAR_LIMIT = 255;

	// AddLocationPopup
	AL.ADD_LOCATION_POPUP_ID = 'add-location-popup';
	AL.ADD_LOCATION_POPUP_ELEMENTS_ID = 'add-location-popup-elements';
	AL.ADD_LOCATION_POPUP_ELEMENTS_URL = '/pages/template/addLocationPopup';
	AL.ADD_LOCATION_POPUP_SUBMIT_URL = '/ajax/add_new_location';

	/* TODO Move constants for SMB to somewhere relate to SMB (AL.smb.Constants.js?) */
	AL.SMB_HOME_URL = '/smbhome';
	AL.SMB_DELETE_BIZ_URL = '/smb/delete_business';

	// PromotePanel
	AL.PROMOTE_PANEL_TEMPLATE_ID = 'promote-panel-container';
	AL.PROMOTE_PANEL_TEMPLATE_URL = '/pages/template/promotePanel';
	AL.PROMOTE_PANEL_SUBMIT_URL = '/smb/step3_save';
	AL.PROMOTE_PANEL_ERROR_TYPE_MESSAGE = 'Please enter a promote message';
	AL.PROMOTE_PANEL_ERROR_TYPE_MESSAGE_TOO_MUCH = 'Only 140 characters allowed in message';
	AL.PROMOTE_PANEL_ERROR_TYPE_HEADLINE = 'Please type your promotion headline';
	AL.PROMOTE_PANEL_ERROR_TYPE_HEADLINE_TOO_MUCH = 'Only 40 characters allowed in headline';
	AL.PROMOTE_PANEL_ERROR_START_DATE = 'Please enter start time';
	AL.PROMOTE_PANEL_ERROR_END_DATE = 'Please enter end time';
	AL.PROMOTE_PANEL_ERROR_UNKNOWN = 'There was an error while processing the request';
	AL.PROMOTE_PANEL_DELETE_CONFIRMATION = 'Are you sure you want to delete this promotion?';
	AL.PROMOTE_PANEL_CALENDAR_IMAGE = '/images/beta2/calendar.png';
	AL.PROMOTE_PANEL_ALL_PROMOTIONS_URL = '/smb/get_promo_messages';
	AL.PROMOTE_PANEL_SAVE_URL = '/smb/save_promo_message';
	AL.PROMOTE_PANEL_UPDATE_URL = '/smb/update_promo_message';
	AL.PROMOTE_PANEL_DELETE_URL = '/smb/delete_promo_message';

	// Modal
	AL.MODAL_IMG_CROP_TEMPLATE_ID = 'modal_container';
	AL.MODAL_IMG_CROP_TEMPLATE_URL = '/pages/template/modalImageCrop';

	// ConfirmationPopup
	AL.CONFIRMATION_POPUP_ID = 'confirmation-popup';
	AL.CONFIRMATION_POPUP_ELEMENTS_ID = 'confirmation-popup-elements';
	AL.CONFIRMATION_POPUP_ELEMENTS_URL = '/pages/template/confirmationPopup';

	// EditBusinessInfoPanel
	AL.EDIT_BUSINESS_INFO_PANEL_TEMPLATE_ID = 'ebiz-panel-container';
	AL.EDIT_BUSINESS_INFO_PANEL_TEMPLATE_URL = '/pages/template/editBusinessInfoPanel';
	AL.EDIT_BUSINESS_INFO_PANEL_GET_INFO = '/smb/get_business_listing';
	AL.EDIT_BUSINESS_INFO_PANEL_SAVE_INFO = '/smb/save_business_listing';
	AL.EDIT_BUSINESS_INFO_ENTER_NAME = 'Please enter business listing name';
	AL.EDIT_BUSINESS_INFO_ENTER_ADDRESS = 'Please enter business address';
	AL.EDIT_BUSINESS_INFO_ENTER_CITY = 'Please enter city and state';
	AL.EDIT_BUSINESS_INFO_ENTER_VALID_CITY = 'Please enter a valid city and state';
	AL.EDIT_BUSINESS_INFO_ENTER_PHONE = 'Please enter business phone number';
	AL.EDIT_BUSINESS_INFO_INVALID_PHONE = 'Please enter a valid phone number';
	AL.EDIT_BUSINESS_INFO_ENTER_CAT = 'Please type and select a valid category';
	AL.EDIT_BUSINESS_INFO_INVALID_CAT = 'Please type and select a valid category';

	// PaymentPanel
	AL.PAYMENT_PANEL_TEMPLATE_ID = 'payment-panel-container';
	AL.PAYMENT_PANEL_TEMPLATE_URL = '/pages/template/paymentPanel';
	AL.PAYMENT_PANEL_ARIA_GET = '/smb/aria_get_account';
	AL.PAYMENT_PANEL_ARIA_SAVE = '/smb/aria_save_account';

	AL.PAYMENT_PANEL_ENTER_CC = 'Please enter card number';
	AL.PAYMENT_PANEL_ENTER_MONTH = 'Please select card expired month';
	AL.PAYMENT_PANEL_ENTER_YEAR = 'Please select card expired year';
	AL.PAYMENT_PANEL_ENTER_SEC_CODE = 'Please enter card security code';
	AL.PAYMENT_PANEL_ENTER_FNAME = 'Please enter billing first name';
	AL.PAYMENT_PANEL_ENTER_LNAME = 'Please enter billing last name';
	AL.PAYMENT_PANEL_ENTER_ADDRESS = 'Please enter billing address';
	AL.PAYMENT_PANEL_ENTER_PHONE = 'Please enter phone number';
	AL.PAYMENT_PANEL_INVALID_PHONE = 'Please enter a valid phone number';
	AL.PAYMENT_PANEL_ENTER_STATE = 'Please enter state or province';
	AL.PAYMENT_PANEL_ENTER_ZIP = 'Please enter zip code';
	AL.PAYMENT_PANEL_ENTER_CITY = 'Please enter city';
	AL.PAYMENT_PANEL_SAVING_SUCCESSFUL = 'Thank you! Your payment information has been saved.';
	AL.PAYMENT_PANEL_ENTER_ACCEPT = 'Please accept the Privacy Policy and Terms of Service';
	AL.PAYMENT_PANEL_ENTER_EMAIL = 'Please enter billing email address';
	AL.PAYMENT_PANEL_INVALID_EMAIL = 'Please enter a valid email address';

	AL.CREATE_BIZ_ACCOUNT_POPUP_TEMPLATE_ID = 'create-biz-popup-container';
	AL.CREATE_BIZ_ACCOUNT_POPUP_TEMPLATE_URL = '/pages/template/createBusinessAccountPopup';
	AL.CREATE_BIZ_ACCOUNT_INVALID_NAME = 'Please enter a valid account name';
	AL.CREATE_BIZ_ACCOUNT_NEW = '/smb/create_account';

	AL.CLAIM_BUSINESS_CONFIRM_SELECT_ACCOUNT = 'Please select an account or create a new account for your claim business';

	AL.FILE_UPLOAD_POPUP_ID = 'file-upload-popup-container';
	AL.FILE_UPLOAD_POPUP_ELEMENTS_TEMPLATE_URL = '/pages/template/fileUploadPopup';
	AL.FILE_UPLOAD_POPUP_ELEMENTS_ID = 'file-upload-popup-elements';
	AL.FILE_UPLOAD_SUBMIT_URL = '/image/upload';
	AL.CSV_FILE_UPLOAD_SUBMIT_URL = '/ajax/csv_upload';
	AL.FILE_UPLOAD_MAX_SIZE = 5242880; // 5M

	AL.IMAGE_CROP_URL = '/image/crop';
	AL.IMAGE_CROP_PROMO = 'promo';
	AL.IMAGE_CROP_PROFILE = 'profile';

	AL.IMAGE_DELETE_URL = '/image/delete';
	AL.IMAGE_DELETE_PROMO = 'promo';
	AL.IMAGE_DELETE_PROFILE = 'profile';
	AL.IMAGE_PROMPT = 'Are you sure you want to delete your business avatar?';

	// Cancel cropping image
	AL.IMAGE_CANCEL_URL = '/image/cancel';

	AL.DIALOG_TEMPLATE_ID = 'dialog-container';
	AL.DIALOG_TEMPLATE_URL = '/pages/template/dialog';
	AL.CONFIRM_DIALOG_TEMPLATE_ID = 'verify-yes-dialog-elements';
	AL.CONFIRM_DIALOG_TEMPLATE_URL = '/pages/template/dialog';

	AL.IMAGE_CROPPING_DLG_ELEMENTS_TEMPLATE_ID = 'image-cropping-elements';
	AL.IMAGE_CROPPING_DLG_ELEMENTS_TEMPLATE_URL = '/pages/template/imageCroppingDlg';

	// Email unverified, member status pending messaging //
	AL.STATUS_PENDING_CONT = 'status_pending_info_container';
	AL.STATUS_PENDING_TEMPLATE_URL = '/pages/template/statusPendingInfo';
	AL.FB_STATUS_PENDING_TEMPLATE_URL = '/pages/template/statusPendingInfoFB';
	AL.LOGGED_IN_NOEMAIL_CONT = 'loggedInNoEmail';
	AL.LOGGED_IN_NOEMAIL = '/pages/template/loggedInNoEmail';

	// Listing Preview
	AL.LISTING_PREVIEW_POPUP_ID = 'listing-preview-popup';
	AL.LISTING_PREVIEW_ELEMENTS_ID = 'listing-preview-popup-elements';
	AL.LISTING_PREVIEW_ELEMENTS_URL = '/pages/template/listingPreviewPopup';

	// Signin invitation //
	AL.FACEBOOK_INVITE_POST = "";
	AL.ALIKELIST_INVITE_POST = "/ajax/send_invites_to_queue";
	AL.EXT_SERVICE_INVITE_POST = "/ajax/send_invites_to_queue";
	AL.EMAIL_INVITE_POST = "/ajax/send_invites_to_queue";
	AL.MAX_INVITES_ALLOWED = 20;

	AL.DEAL_CATEGORY_TEMPLATE_URL = '/pages/template/deal_category';

	// Admin Tools
	AL.CRM_ELEMENTS_ID = 'like-context-element-crm';
	AL.ADMIN_ELEMENTS_ID = 'like-context-element-admin';
	
	/**
	 * Popup Panles
	 */
	AL.POPUP_PANELS_ID = 'popup-panels';
	AL.POPUP_PANELS_URL = '/pages/template/popupPanels';
	
	/**
	 * Icon Tabs Panel
	 */
	AL.ICON_TABS_PANEL_ID = 'icon-tabs-panel';
	AL.ICON_TABS_PANEL_URL = '/pages/template/iconTabsPanel';
	
	/**
	 * Invitation Panel Id
	 */
	AL.INVITATION_PANEL_TEMPLATE_ID = 'invitation-panel';
	AL.INVITATION_PANEL_TEMPLATE_URL = '/pages/template/invitationPanel';
	AL.ACCEPT_INVITE_POST_URL = '/ajax/accept_add_friend_request';
	AL.IGNORE_INVITE_POST_URL = '/ajax/ignore_add_friend_request';
	
	/**
	 * Invitation Panel Id
	 */
	AL.RESPONSE_PANEL_TEMPLATE_ID = 'response-panel';

	/**
	 * Invitation Panel Id
	 */
	AL.REQUEST_PANEL_TEMPLATE_ID = 'request-panel';

	/**
	 * Facebook Add Panel Id
	 */
	AL.FACEBOOK_ADD_PANEL_TEMPLATE_ID = 'facebook-add-panel';
	AL.FACEBOOK_ADD_PANEL_TEMPLATE_URL = '/pages/template/facebookAddPanel';
	AL.FACEBOOK_ADD_PANEL_WELCOME = '';
	
	/**
	 * Email Provider Add Panel
	 */
	AL.EMAIL_PROVIDER_ADD_PANEL_TEMPLATE_ID = 'email-provider-add-panel';
	AL.EMAIL_PROVIDER_ADD_PANEL_TEMPLATE_URL = '/pages/template/emailProviderAddPanel';
	AL.EMAIL_PROVIDER_ADD_PANEL_WELCOME = '';
	AL.EMAIL_PROVIDER_PANEL_TYPE_INVITE = 'INVITE';
	AL.EMAIL_PROVIDER_PANEL_TYPE_ASK = 'ASK';
	AL.EMAIL_PROVIDER_ADD_PANEL_BT_TEXT_INVITE = 'Invite Friends';
	AL.EMAIL_PROVIDER_ADD_PANEL_BT_TEXT_ASK = 'Get Referral';
	AL.EMAIL_PROVIDER_ADD_PANEL_PROCESS_URL = '/social/send_friends_messages';
	AL.IMPORT_EMAIL_CONTACTS = '/ajax/import_contacts';
	/**
	 * Like List Add Panel
	 */
	AL.LIKE_LIST_ADD_PANEL_TEMPLATE_ID = 'like-list-add-panel';
	AL.LIKE_LIST_ADD_PANEL_TEMPLATE_URL = '/pages/template/likeListAddPanel';
	AL.LIKE_LIST_ADD_PANEL_WELCOME = 'LikeList Add Panel Welcome message.';
	
	/**
	 * Facebook locale. Global plan's coming soon
	 */
	AL.FACEBOOK_LOCALE = 'en_US'; 

	/**
	 * Facebook social sync update url 
	 */
	AL.FACEBOOK_SYNC_UPDATE_URL = '/ajax/fb_page_sync/';           // /ajax/fb_page_sync/<true or false value>/<fb_fan_page_id>/<business_id>
	
	/**
	 * URL to get pages which current FB user has administrative role.
	 */
	AL.FACEBOOK_GET_ADMIN_PAGES = '/ajax/get_fb_admin_pages';//'/js/test/resources/facebook-fan-pages-json.php';

	/**
	 * Twitter social sync update url
	 */
	AL.TWITTER_SYNC_UPDATE_URL = '/ajax/twitter_sync/';            // /ajax/twitter_sync/<true or false value>

	/**
	 * Connector url which generates correct OAuth URL to connect to Twitter.
	 * javascript -> open this url in a popup -> it generates the correct Twitter OAuth url -> redirect -> grant permission
	 */
	AL.TWITTER_CONNECTOR_URL = '/ajax/twitter_oauth';

	/**
	 * Foursquare social sync update url
	 */
	AL.FOURSQUARE_SYNC_UPDATE_URL = '/ajax/foursquare_sync/';            // /ajax/foursquare_sync/<true or false value>

	/**
	 * Connector url which generates correct OAuth URL to connect to Foursquare.
	 * javascript -> open this url in a popup -> it generates the correct Foursquare OAuth url -> redirect -> grant permission
	 */
	AL.FOURSQUARE_CONNECTOR_URL = '/ajax/foursquare_oauth';

	/**
	 * Send sharing list by email processor on back-end 
	 */
	AL.SEND_SHARING_LIST_URL = '/mylist/ajax_send_sharing_list';
	
	/**
	 * Get all friends ajax entry.
	 */
	AL.GET_ALL_FRIENDS_URL = '/ajax/friends_json/';
	
	/**
	 * Tiny url creator for sharing list (not a general used service, sharing list only, it has tracking)
	 * @see http://72.167.201.133:9090/show_bug.cgi?id=6385
	 */
	AL.CREATE_TINY_URL_FOR_SHARING_LIST_URL = '/mylist/ajax_create_tiny_url';
	
	/**
	 * Add Friends and Get Referral popups constants.
	 */
	AL.INVITE_FRIENDS_POPUP_ID = 'invite-friends-popup-container';
	AL.GET_REFERRAL_POPUP_ID = 'get-referral-popup-container';
	AL.LOAD_INVITE_MESSAGE_URL = '/ajax/load_invite_message';
	AL.SEND_FRIENDS_MESSAGES_URL = '/social/send_friends_messages';
	AL.DISMISS_REFERRAL_URL = '/ajax/dismiss_ask_response';
	AL.IGNORE_ASK_REQUEST_URL = '/ajax/ignore_ask_request';
	AL.RECOMMEND_ASK_REQUEST_URL = '/ajax/recom_ask_request';
	
	/**
	 * SMB Promo Messages message type constants.
	 */
	AL.MESSAGE_TYPE_MESSAGE = 'Message';
	AL.MESSAGE_TYPE_OFFER = 'Offer';
	AL.MESSAGE_TYPE_THIRD_PARTY = 'ThirdPartyOffer';
	AL.MESSAGE_TYPE_SOCIAL_COUPON = 'SocialCoupon' ;

})();