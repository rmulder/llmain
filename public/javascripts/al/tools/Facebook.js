/**
 * AL.tools.Facebook.js - Alikelist interation with Facebook.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * @class Alikelist interation with Facebook
 * @name AL.tools.Facebook
 * @requires jQuery
 * @requires jsface
 * @requires AL.Logger
 *
 * @author Tan Nhu - initial API and implementation
 * @author Eugene Goldin - initFacebookAPI & facebookConnect
 */
(function(){
	// Internal constants and variables
	var LIKELIST = 'LikeList',
		HOST = window.location.protocol + '//' + window.location.host,
		DEFAULT_IMG = HOST + '/images/beta2/al_avatar.png',
		log = AL.Logger, token;
		
	jsface.def({
		cls: 'Facebook',
		on: AL.tools,
		singleton: true,
		as: function()
		/** @lends AL.tools.Facebook */
		{
			/**
			 * Class vars
			 */
			var apiStatus = false;
			var apiOnLoadQueue = [];
			
			// default login callback
			var loginCallback = function(data) {
				if (data) {
					if(data == "Invalid Request"){
						document.location = "/registration";
					} else {
						var ajaxdata = $.evalJSON(data);
						if (ajaxdata) {
							document.location = ajaxdata.redirect;
						}
					}
				}
			};

			/**
			 * Submit conversion to Facebook.
			 * @param params conversion parameters.
			 */
			function submitConversion(params){
				// If Facebook conversion script is not there, get it
				if ( !window.FB || !window.FB.trackConversion || window.FB.Insights || window.FB.Insights.impression){
					$.getScript('//ah8.facebook.com/js/conversions/tracking.js');
				}

				// Make sure we call Facebook conversion only when its script is available. Thanks to jsface.wait
				jsface.wait(function(){
					return ((window.FB && window.FB.trackConversion) || (window.FB && window.FB.Insights && window.FB.Insights.impression));
				}, function(){
					var fn = (window.FB && window.FB.trackConversion) ? FB.trackConversion : FB.Insights.impression;
					fn(params);
					AL.tools.Facebook.conversionSubmitted = true;
					AL.Logger.debug('Submit conversion to Facebook');
				}, null, 5000, function(){
					AL.tools.Facebook.conversionSubmitted = true;
				});
			}

			/**
			 * Initialize Facebook API
			 * Supports multiple calls to init()
			 * @param {Boolean} connect indicates whether to start a session or just load in the api
			 * @param {Object} options
			 * 			- callback: function that is called on load (after session is started if connect is true)
			 */
			var initFacebookAPI = function(connect, options) {
				var opts = $.extend({
						callback: function() {}
					}, options);
					
				// save the connect bool in the options
				opts.connect = connect;

				/**
				 * Fire Callback, a private function that checks for
				 * connection and then fires the callback (used by FireCallbacks)
				 */
				var fireCallback = function(options) {
					// allow override of options
					options = options || opts;
					
					// check that we have a connection
					if (options.connect) {
						FB.Connect.requireSession(function(){
							FB.Facebook.get_sessionWaitable().waitUntilReady(function(response) {
								options.callback(response);
							});
						});
					} else {
						options.callback();
					}
				};
				
				/**
				 * FireCallbacks, should be used over FireCallback, as this function 
				 * ensures that any queued functions will also be run
				 */
				var fireCallbacks = function() {
					// fire current callback (the original caller of the fb init)
					fireCallback();
					
					// fire queued callbacks and remove them from queue
					while (apiOnLoadQueue.length) {
						fireCallback(apiOnLoadQueue.shift());
					}
				};
				
				/**
				 * requireFeatures function
				 */
				var requireFratures = function() {
					FB_RequireFeatures(["XFBML"], function ensureInit() {
						FB.init(Fb_API_KEY, "/fb-receiver.php");
						FB.ensureInit( function receiver() {
							FB.Facebook.init(Fb_API_KEY, '/fb-receiver.php');
							apiStatus = 'loaded';
							fireCallbacks();
						});
					});
				};
				
				// code that runs on init
				if (apiStatus) {
					if (apiStatus === 'loaded') {
						// if loaded fire callbacks
						fireCallbacks();
					} else {
						// if loading, queue the current request
						apiOnLoadQueue.push(opts);
					}
				} else {
					// update api status
					apiStatus = 'loading';
					// prevent jQuery from appending cache busting string to the end of the FeatureLoader URL
					var cache = $.ajaxSettings.cache;
					// Load FeatureLoader asynchronously. Once loaded, execute Facebook init
					$.ajaxSettings.cache = true;
					if (typeof(window.FB) !== 'undefined') {
						requireFratures();
					} else {
						//  just in case the original load does not work.
						$.getScript('http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US', requireFratures);
					}
					// Restore jQuery caching setting
					$.ajaxSettings.cache = cache;
				}//end if loaded
			};


			/**
			 * Global facebook connect
			 * @param register
			 * @param persist
			 * @param {String} callback function to be fun after attempted login (defaults to loginCallback if none present)
			 */
			function facebookConnect(register, persist, callback) {
				initFacebookAPI(true, {
					callback: function(response) {
						//check for extended permission
						//AL.app.loadingFriendStatus.getExtendedPermissions();
								//requireFratures();
								FB.Facebook.apiClient.users_hasAppPermission('email', function(a) {
									if (!a) {
										try {
										FB.Connect.showPermissionDialog("email", function(d) {
											var result =  isEmailFound();
											if (result == "true") {
												//'AL.app.loadingFriendStatus.askMergeEmailAccounts', callback
												// ask user if they want to merge
												AL.app.loadingFriendStatus.askMergeEmailAccounts(function(merge){
													processFBLogin(persist, response, merge, callback);
												});
											} else {
												processFBLogin(persist, response, false, callback);
											}
										});
										} catch (e) {
											AL.Logger.info('Caught Facebook lib error');
											processFBLogin(persist, response, false, callback);
										}
									} else {
										processFBLogin(persist, response, false, callback);
									}

								});
//								} else {
//									processFBLogin(false);
//								}
					}
				});
			}


			function processFBLogin(persist, response, doMerge, callback) {
				AL.Logger.info('processFBLogin');
				if (typeof AL.app.loadingFriendStatus === 'object') {
					AL.app.loadingFriendStatus.showLoader();
				}
				insertSocialRecord(persist, response, doMerge, callback);

			}


			function isEmailFound() {
				var returnvar = "here";
				$.ajax({
					type:"POST",
					url:"/social/is_email_found",
					data:'',
					async: false,
					success:function(response){
								returnvar = response;
							}
				});
				return returnvar;
				//AL.app.loadingFriendStatus.askMergeEmailAccounts();
				//return true;
			}

			/**
			 * Ported Facebook Tools
			 */
			function insertSocialRecord(persist, response, doMerge, callback){
				AL.Logger.info('insertSocialRecord');
				/**
				 * determine if we need to insert a new user based on facebook info,
				 * or just update their info in Alikelist
				 */
				var url = "/login/";
				var data = "sn=1";
				if ($('#iuid').val()) {
					data += "&iuid=" + $('#iuid').val();
				}
				if (persist) {
					data += '&p=1';
				}
				if (doMerge) {
					data += '&m=1';
				}
				// ~~N~~ variable change to redirect back to curpage - #5123
				data += '&curpage=' + window.location.href;  //  "http://localhost/"; //

				if (response != null) {
					data += '&fs='+response.session_key;
				}

				if (typeof callback !== 'function') {
					callback = loginCallback;
				}
				
				$.post(url, data, function insertSocialAjax(data, type){
					AL.Logger.info('insertSocialRecord - track facebook login');
					// track facebook login and fire callback
					AL.Tracker.track('/FBSignIn.al');
					callback(data);
				});

			}

			return {
				/**
				 * Submit conversion to Facebook when a successful new user registration is made.
				 */
				submitNewUserRegistrationConversion: function(){
					AL.tools.Facebook.conversionSubmitted = false;
					submitConversion({ id: 6002391613766, h: '14b7ed03dd' });
				},

				/**
				 * Submit conversion to Facebook when a successful new SMB sign up is made.
				 */
				submitSMBSignUpConversion: function(){
					AL.tools.Facebook.conversionSubmitted = false;
					submitConversion({ id: 6002391614166, h: '79aebb160c' });
				},

				/**
				 * Facebook login through facebook
				 */
				connect: facebookConnect,

				/**
				 * Initialize Facebook API, step thru for {@link AL.Facebook-initFacebookAPI}
				 * @param {Boolean} connect indicates whether to start a session or just load in the api
				 * @param {Object} options
				 * 			- callback: function that is called on load (after session is started if connect is true)
				 */
				init: initFacebookAPI,
				
				/**
				 * Get uid's facebook friends
				 */
				getFriends: function(callback, is_app_user) {
					AL.Logger.info('insertSocialRecord - getFriends');
					callback = callback || $.noop;
					initFacebookAPI(true, {
						callback: function() {
							api = FB.Facebook.apiClient;
							uid = FB.Connect.get_loggedInUser();
							api.fql_query(
								"SELECT uid, first_name, last_name, pic, email FROM user WHERE uid " +
								" IN (SELECT uid2 FROM friend WHERE uid1=" + uid + ") " + (is_app_user ? "AND is_app_user" : "" ) +
								" ORDER BY first_name",
								callback
							);
						}
					});
		        },
				
				/**
				 * Write a message to current Facebook user's wall (Old Facebook API).
				 * @param message {String} the message.
				 * @param success {Function} success function.
				 * @param failure {Function} failure function.
				 */
				writeToWall: function(opts){
					opts = jsface.merge({
						message: 'Put your message here',
						name: LIKELIST,
						caption: 'LikeList is the fastest way friends can share and discover trusted local businesses.',
						description: '',
						href: HOST,
						img: DEFAULT_IMG, // On local, FB API does not show avatar, live is ok
						success: jsface.emptyFn,
						failure: jsface.emptyFn
					}, opts);
					
					var publish = {
						method: 'stream.publish',
						message: opts.message,
						attachment: {
							name: opts.name,
							caption: opts.caption,
						    description: opts.description,
						    href: opts.href,
						    media: [{
						        type: 'image',
						        href: opts.href,
						        src: opts.img
						    }]
						},
						action_links: [{ text: opts.name, href: opts.href }]
					};
					
					if (opts.friend_id){
						publish.target_id = opts.friend_id;
					}
					
					AL.tools.Facebook.init(true, { callback: function(){
						FB.Connect.streamPublish(publish.message, publish.attachment, publish.action_links, publish.target_id, '', function(post_id, exception){
							if (post_id) {
							} else {
							}
						});
					}});				
				},

				/**
				 * provide default callback for after done with login
				 */
				registerCallback: function(rc) {
					loginCallback = rc;
				},
				
				/**
				 * Load Facebook script to the page, then make sure its init() get called.
				 */
				loadScript: function(callback){
					AL.Logger.info('insertSocialRecord - loadScript');
					var callback = jsface.isFunction(callback) ? callback : jsface.emptyFn,
						flag = false;
					
					if (window.FB){
						callback();
					} else {
						jsface.wait(function(){
							return flag && window.FB;
						}, callback);
					}
					
					// Check if FB exists or not
					if ( !window.FB){
						// Load its script from Facebook
						log.debug('Loading Facebook script');
						$.getScript('//connect.facebook.net/' + AL.FACEBOOK_LOCALE + '/all.js');
						
						// Make sure init() get called before everything else
						jsface.wait(function(){
							return window.FB;
						}, function(){
							//FB.Facebook.init(Fb_API_KEY, '/fb-receiver.php');
							log.debug('Initializing Facebook');
							
							// Add fb-root element (Facebook specific DOM) to page if it is not there
							if ($('#fb-root').length == 0){
								$('<div id="fb-root"></div>').appendTo($('body'));
							}
							FB.init({ appId: AL.Profile.facebookAppID, status: true, cookie: true, xfbml: true });
							flag = true;
						});
					} else {
						flag = true;
					}
				},
				
				/**
				 * Ask for Facebook permission.
				 * 
				 * Dev note: On Consumer site, we are using old Facebook SDK. Remove completely the old SDK
				 * by: delete window.FB; before calling loadScript or askPermission. 
				 * 
				 * @param permission {Map} Facbook permission params. Refer to Facebook document for details.
				 * @param success {Function} success callback, optional. Get called as success(response).
				 * @param failure {Function} failure callback, optional. Get called as failure(response).
				 */
				askPermission: function(permission, success, failure){
					AL.Logger.info('insertSocialRecord - loadScript');
					// Normalize params
					success = jsface.isFunction(success) ? success : jsface.emptyFn;
					failure = jsface.isFunction(failure) ? failure : jsface.emptyFn;
					
					// Build callback
					var cb = function(response) {
					    if (response.session) {
					    	if (response.perms) {
					    		success(response);
					    	} else {
					    		failure(response);
					    	}
					    } else {
					    	failure(response);
					    }
					 };
					 
					 FB.login(cb, permission);
				},
				
				/**
				 * Login to Likelist using Facebook account. Grant for normal Facebook permission.
				 * @param success {Function} success callback, optional. Get called as success(response).
				 * @param failure {Function} failure callback, optional. Get called as failure(response).
				 */
				login: function(success, failure){
					success = jsface.isFunction(success) ? success : jsface.emptyFn;
					failure = jsface.isFunction(failure) ? failure : jsface.emptyFn;					

					FB.login(function(response) {
					    if (response.session) {
					    	success(response);
					    	token = response.session.access_token;
					    } else {
					    	token = undefined;
					    	failure(response);
					    }
					});
				},

				/**
				 * Write a message to current Facebook user's wall.
				 * @param message {String} the message.
				 * @param success {Function} success function.
				 * @param failure {Function} failure function.
				 */
				writeToWall2: function(opts){
					opts = jsface.merge({
						message: 'Put your message here',
						name: LIKELIST,
						caption: 'LikeList is the fastest way friends can share and discover trusted local businesses.',
						description: '',
						href: HOST,
						img: DEFAULT_IMG, // On local, FB API does not show avatar, live is ok
						success: jsface.emptyFn,
						failure: jsface.emptyFn
					}, opts);
					
					var publish = {
						method: 'stream.publish',
						message: opts.message,
						attachment: {
							name: opts.name,
							caption: opts.caption,
						    description: opts.description,
						    href: opts.href,
						    media: [{
						        type: 'image',
						        href: opts.href,
						        src: opts.img
						    }]
						},
						action_links: [{ text: opts.name, href: opts.href }]
					};
					
					if (opts.friend_id){
						publish.target_id = opts.friend_id;
					}
					
					FB.ui(publish, function(response){
						var fn = response ? opts.success : opts.failure;
						fn(response);
					});				
				},
				
				/**
				 * Get list of current user's friends.
				 */
				getFriends2: function(callback){
					var globalCallbackName = '_facebook_get_friends2_callback',
						url = 'https://graph.facebook.com/me/friends?access_token=' + token + '&callback=' + globalCallbackName;
					
					window[globalCallbackName] = function(friends){
						callback = jsface.isFunction(callback) ? callback : jsface.emptyFn;
						callback(friends);
						window[globalCallbackName] = undefined;
					}
					
					$.getScript(url);
				},
				
				/**
				 * Write a message to a friend's wall.
				 * @param message {String} the message.
				 * @param success {Function} success function.
				 * @param failure {Function} failure function.
				 */
				writeToFriendWall: function(message, success, failure){
					log.debug('To be implemented');
				},
				
				/**
				 * Public to fan page permission constant. Use with askPermission().
				 * Note: Define permission constants here, not somewhere else.
				 */
				PUBLISH_TO_FAN_PAGE_PERMISSION: {
				    perms: 'publish_stream, offline_access, manage_pages'/*,
				    enable_profile_selector: 1*/
				},
				
				/**
				 * Email  access permission. Use with askPermission().
				 */
				EMAIL_ACCESS_PERMISSION: {
					perms: 'email'
				}
			};
		}
	});

})();