/**
 * InitPopups.js - Alikelist JavaScript Consumer Popups Initializations.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * @class Initialize all site popups
 * @author EG - 1/13/2010
 */

AL.app.InitPopups = (function(){
	// Static loggers
	var log = AL.Logger;
	/**
	 * Popup object, containing all popups
	 */
	var popups = {};
	popups.unauthLoginPopups = {};


	/**
	 * joinPopup
	 * initialize the login popups
	 * @property {Boolean} auto auto initialize
	 * @property {AL.widgets.joinPopup[]} myPopups all popups currently initialized
	 * @property {function} init initialization function
	 */
	popups['joinPopup'] = (function(){
		var myPopups = {};
		var createPopup = function(i, elt){
			$(elt).unbind('click').bind('click', function binde(e){
				$(this).unbind('click', binde);
				myPopups[$(elt).attr('id')] = new AL.widgets.JoinPopup({
						anchor: $(elt).attr('id'),
						autoShow: true,
						align: 'auto',
						onDone: function(data) {
                                                    if (data) {
							if (data == "Invalid Request"){
								document.location = "/";
							} else {
								try {
									var ajaxdata = $.evalJSON(data);
									document.location = ajaxdata.redirect;
								} catch (error){
                                                                    // Special case for local area page
                                                                    if ($('body').attr('id') in { mylist_show: 1, business_listing: 1 } ){
									document.location.href = document.location.href;
                                                                    } else {
									document.location = '/home';
                                                                    }
                                                                }
                                                        }
                                                    } else {
							document.location = json.redirectPage;
                                                    }
						},
						dataSource: function() {}
					});

				
			});

			
		};

		return {
			auto:true,
			myPopups:myPopups,
			init:function(container){
				$('.btn_head_join', container).each(createPopup);
			}
		};
	})();


/**
	 * loginPopup
	 * initialize the login popups
	 * @property {Boolean} auto auto initialize
	 * @property {AL.widgets.loginPopup[]} myPopups all popups currently initialized
	 * @property {function} init initialization function
	 */
	popups['loginPopup'] = (function(){
		var myPopups = {};
		var createPopup = function(i, elt){
			$(elt).unbind('click').bind('click', function binde(e){
				$(this).unbind('click', binde);
				var that = this;
				var redirect;
				if($(this).attr('rel') !== undefined) {
					redirect = $(this).attr('rel');
				} else if ($(this).hasClass('smb_login')) {
					redirect = '/smbhome';
				}
				//$.getJSON("/login", function(json){
					//if (!!redirect) {
					//	json.redirectPage = redirect;
					//}
					// Lazy creating popup
					myPopups[$(elt).attr('id')] = new AL.widgets.LoginPopup({
						anchor: $(elt).attr('id'),
						autoShow: true,
						align: 'auto',
						onDone: function(data) {
							if (data) {
								if (data == "Invalid Request"){
									document.location = "/registration";
								} else {
									try {
										var ajaxdata = $.evalJSON(data);
										document.location = ajaxdata.redirect;
									} catch (error){
										// Special case for local area page
										if ($('body').attr('id') in { mylist_show: 1, business_listing: 1 } ){
											document.location.href = document.location.href; 
										} else {
											document.location = '/home';
										}
									}
								}
							} else {
								document.location = json.redirectPage;
							}
						},
						dataSource: function() {
                                                    return {"username":"jma@test.com","rememberMe":false,"autoLogin":false,"queryString":"","redirectPage":"\/home","iid":0}
							//return json;
						}
					});
				//});
			});

			// show popup if has auto class
			if($(elt).hasClass('auto')){
				$(elt).trigger('click');
			}
		};

		return {
			auto:true,
			myPopups:myPopups,
			init:function(container){
				$('.btn_signin', container).each(createPopup);
			}
		};
	})();


	/**
	 * Public Functions
	 */
	return {
		/**
		 * AL.app.InitPopups.init function accepts a parameter that limits the
		 * scope of the popup initialization. By default this parameter is document,
		 * so if you don't set it the popups will be initialized globally.
		 *
		 * This can be useful when chunks of the DOM are replaced via ajax.
		 * We need to re-attach events to popups in the replaced chunks without
		 * affecting the unchanged DOM elements, which we can do by:
		 *
		 * @example AL.app.InitPopups.init($('#replaced_content_id'));
		 * @param {Element} [container] - the context in which to
		 * initialize the popups
		 *
		 */
		init:function(container){

			// allow for a specific area in which to initialize
			if(typeof container == 'undefined'){
				container = document;
			}

			for(var popup in popups){
				if(popups[popup].auto){
					popups[popup].init(container);
				}
			}
			AL.Logger.debug('InitPopups ready');
		},

		/**
		 * Array of popups, indexable
		 */
		popups:popups
	};
})();

$(document).ready(function(){
	AL.app.InitPopups.init();

	// Patch: Cancel position on IE7
	if (jsface.browser.ie7){
		$('.bt-cancel').css('vertical-align', '30%');
	}
});