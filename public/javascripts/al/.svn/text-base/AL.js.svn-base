/**
 * AL.js - Alikelist JavaScript base namespaces and utilities.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * Developers:
 *     Tan Nhu - initial API and implementation
 *     Eugene Goldin - added static namespace definitions
 *     Jonathan Ma - move it to rails site and clean up useless code
 */



(function(){

        /**
         * @namespace Alikelist Namespace definition
         * @version development branch
         */
        AL = {
                /**
                 * @namespace Alikelist applications namespace; singleton applications
                 */
                app: {},

                /**
                 * @namespace Alikelist widgets namespace; reusable ui components
                 */
                 ui: {},
                /**
                 * Alikelist UI namespace. All UI classes must be under this namespace.
                 * @alias AL.ui
                 */
                widgets: {},

                /**
                 * @namespace Alikelist test namespace; reusable testing components (selenium, etc.)
                 */
                test: {},

                /**
                 * @namespace Alikelist tools namespace; third-party tools
                 */
                tools: {},
                /**
                 * Alikelist components namespace. UI snippets or builders.
                 * @alias AL.components
                 */
                components : {},

                /**
                 * @namespace Alikelist utilities namespace; reusable code snippets and methods
                 */
                utils: {}
        };

        /* Global configuration constants
         * All constant names must be in upper case, use underscore to split words.*/

        AL.LOG_LEVEL = 'info';

	/**
	 * Define Alikelist utility class. This class defines base utility functions that can be used
	 * in all web project under AL umbrella.
	 * @alias AL.Utils
	 * @singleton
	 * @test test/ALTest.js
	 */
	jsface.def({
		cls: 'Utils',
		on: AL,
		singleton: true,
		as: function(){
			return {
				/**
				 * Hash a message using MD5 algorithm.
				 * @param msg Message to be hashed.
				 * @return MD5 message.
				 */
				MD5: function(msg){
				},

				/**
				 * Set a cookie.
				 * @param name {String} cookie key.
				 * @param value {Any} cookie value.
				 * @param expireDays {Number} expire days.
				 */
				setCookie: function(name, value, expireDays){
					var date = new Date();
					
					date.setDate(date.getDate() + expireDays);
					document.cookie = name + '=' + escape(value) + ((expireDays == null) ? '' : ';expires=' + date.toUTCString());
				},

				/**
				 * Get a cookie value.
				 * @param name cookie name
				 * @return cookie value or undefined if cookie not found.
				 */
				getCookie: function(name){
					var start, end;

					if (document.cookie.length > 0){
						start = document.cookie.indexOf(name + "=");
						if (start != -1){
							start = start + name.length + 1;
							end = document.cookie.indexOf(";", start);
							if (end == -1){
								end = document.cookie.length;
							}
							return unescape(document.cookie.substring(start, end));
						}
					}
					return undefined;
				},

				clearCookie: function(name){
				},

				clearAllCookies: function(){
				},

				/**
				 * Generate a unique id.
				 * @param prefix prefix for the id.
				 * @return a unique id.
				 */
				genId: function(prefix){
					AL.Utils.genId.counter = AL.Utils.genId.counter ? AL.Utils.genId.counter : 10;
					var counter = AL.Utils.genId.counter;
					AL.Utils.genId.counter++;
					return prefix ? (prefix + '-' + counter) : ('al-id-' + counter);
				},

				/**
				 * Parse the full name field
				 * @param str value of the full_name field
				 * @return array with separated first and last names.
				 */
				parseFullname: function(str) {
					str = str.replace("  ", " "); // remove double spaces
					str = str.replace(/^\s*/, "").replace(/\s*$/, ""); // trim space from front and end
					arr = str.split(" ");
					var name = new Array();
					name[0] = arr[0];
					name[1] = str.substring(name[0].length + 1, str.length);
					return name;
				},

				/**
				 * Validate an email is valid or not. Note: Should make server side validation to complement.
				 * @param email {String} email.
				 * @return true if the email is valid, false if not.
				 */
				validateEmail: function(email){
					var regEx = /^([a-zA-Z0-9_+\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
					return email.match(regEx);
				},

				/**
				 * Validate a email string to determine it contains valid email addresses or not.
				 * @param emails {String} emails. Format is "First Last" <name@domain.dot>, "First Last" <name@domain.dot>
				 * @return an array contains [ name:name, email:email ] entries, or a string represents an error.
				 */
				validateEmails: function(emails){
					var text = emails.split(','),
						len = dataLen = text.length,
						email, entry, contacts = [];

					if ( !len){
						if (AL.Utils.validateEmail(emails)){
							return [{ name: '', email: jsface.trim(emails) }];
						}
						else {
							return 'Oops! Please enter valid email addresses.';
						}
					}

					while (len--){
						if (!jsface.trim(text[len])) {
							continue;
						}

						entry = text[len].split('<');
						if (entry.length === 1){
							email = jsface.trim(entry[0]);
							// Check for error
							if ( !AL.Utils.validateEmail(email)){
								return 'Oops! There is an invalid email entry ' + email + '.';
							}

							contacts.push({
								name: '',
								email: email
							});
						} else if (entry.length === 2){
							email = jsface.trim(entry[1].replace('>', ''));

							// Check for error
							if ( !AL.Utils.validateEmail(email)){
								return 'Oops! There is an invalid email entry ' + email + '.';
							}
							
							contacts.push({
								name: jsface.trim(entry[0].replace(/\"/g, '')),
								email: email
							});
						} else if (entry.length > 2) {
							return 'Oops! There is an invalid email entry ' + text[len] + '.'; 
						}
					}	
					return contacts;
				},
				
				/**
				 * Validate an US phone number.
				 * @param number {String} phone number.
				 * @return true if the number is a valid phone.
				 */
				validatePhone: function(number){
					var regEx = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/;
					return regEx.test(number);
				},
				
				/**
				 * Validate an url.
				 * @param url {String} url.
				 * @return true if the url is valid, false if not.
				 */
				validateUrl: function(url){
					var regEx = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
					return regEx.test(url);
				},

				/**
				 * Check for a city name (pattern City-Name, STATE. i.e: San Jose, CA) is valid or not.
				 * @param city {String} city name and state, separated by a comma
				 * @return true if the city is valid, false if not. 
				 */
				checkCity: function(city){
					var ret = false;
					$.ajax({
						type: 'POST',
						data: { city: city },
						url: AL.CHECK_CITY_URL,
						async: false,
						success: function(data){
							ret = (data == 1);
						}
					});
					return ret;
				},

				/**
				 * Validate an HTML color.
				 * @param color {String} color
				 * @return true if the parameter is a valid HTML color.
				 */
				validateColor: function(color){
					var regEx = /^(#)?([0-9a-fA-F]{3})([0-9a-fA-F]{3})?$/;
					return regEx.test(color);
				},

				/**
				 * Util function to convert rgb(x, x, x) to #xxxxxx.
				 * @param rgb {String} rgb(x, x, x) string.
				 * @return hex color.
				 */
				rgb2hex: function(rgb){
					if (AL.Utils.validateColor(rgb)){
						return rgb;
					}
					var colors = rgb.replace('(', '').replace(')', '').replace('rgb', '').split(','),
						red = colors[0]*1, green = colors[1]*1, blue = colors[2]*1,
						chars = '0123456789ABCDEF';
					return '#' + chars[red >> 4] + chars[red & 15]  + chars[green >> 4] + chars[green & 15]  + chars[blue >> 4] + chars[blue & 15];
				},

				/**
				 * Get the widget template. Load template into the page if it does not exist.
				 * @param templateId DOM id of the template, without '#'.
				 * @param templateUrl Template url.
				 * @param onDone function to be called when template is ready (optional).
				 * @return jQuery object of the template on the page.
				 * @static
				 */
				getTemplate: function(templateId, templateUrl, onDone){
					var template = $('#' + templateId), log = AL.Logger;

					// Load category template from server and append to the bottom of <body/> if it does not exist
					if (template.length == 0){
						$.ajax({ url: templateUrl, async: false, success: function(data){
							template = $(data).appendTo($('body'));
							if (jsface.isFunction(onDone)){
								onDone(template);
							}
						}});
					} else {
						if (jsface.isFunction(onDone)){
							onDone(template);
						}
					}
					// Return the jQuery object of the template on the page
					return template;
				},

				/**
				 * Evaluate a JSON object.
				 * @param data JSON text.
				 * @return JSON object represents data.
				 * @static
				 * TODO Apply native JSON parser.
				 */
				eval: function(data){
					var result;
					try {
						result = eval(data);
					} catch (e1){
						try {
							result = eval('(' + data + ')');
						} catch (e2){
							AL.Logger.error('eval2: Cant eval data ' + data);
						}
					}
					return result;
				},

				/**
				 * Combine error details.
				 * @param {Map} details details JSON from back-end.
				 * @return combined error detail.
				 */
				errorDetails: function(details){
					var result = [];
					jsface.each(details, function(key, value){
						result.push(value);
					});
					return result.join('<br/>');
				},

				/**
				 * jQuery stopPropagation shortcut.
				 */
				stopPropagation: function(e){
					e.stopPropagation();
				},
				
				/**
				 * Show error message.
				 * @param {String} domId Error DOM element id (it has css class error-message).
				 * @param {String} msg Error message.
				 * @param {Number} duration duration (optional).
				 * @param {String} color Text color (optional).
				 */
				showError: function(domId, msg, duration, color){
					var e = $('#' + domId).html(msg);
					color = jsface.isString(color) ?  color : 'red';
					e.css('color', color);
					e.show('fast');
					clearTimeout($('#' + domId).data('errorTimeoutId'));
					$('#' + domId).data('errorTimeoutId', setTimeout(function(){
						$('#' + domId).hide('slow');
					}, jsface.isNumber(duration) ? duration : AL.ERROR_AUTO_HIDE_DURATION));					
				},
				
				/**
				 * Show info message.
				 * @param {String} domId Error DOM element id (it has css class error-message).
				 * @param {String} msg message.
				 * @param {Number} duration duration (optional).
				 */				
				showInfo: function(domId, msg, duration){
					AL.Utils.showError(domId, msg, duration ? duration : AL.ERROR_AUTO_HIDE_DURATION, 'green');
				},
				
				/**
				 * Format separate address parts into one address line.
				 */
				formatAddress: function(address1, address2, citystate, zip){
					address1 = jsface.trim(address1 + '');
					address2 = jsface.trim(address2 + '');
					citystate = jsface.trim(citystate + '');
					zip = jsface.trim(zip + '');
					
					if (address1){
						if (address2){
							address1 = address1 + ', ' + address2;
						}
					} else {
						address1 = address2;
					}
					
					if (address1){
						if (citystate){
							address1 = address1 + ', ' + citystate;
						}
					} else {
						address1 = citystate;
					}

					if (address1){
						if (zip){
							address1 = address1 + ', ' + zip;
						}
					} else {
						address1 = zip;
					}
					
					return address1;
				},
				
				/**
				 * Check the SMB Activation code is valid or not. 
				 */
				isValidSMBActivationCode: function(code){
					var pattern = /^([a-zA-Z0-9_-]+)$/;
					return pattern.test(code);
				},
				
				/**
				 * Pretty format US phone number.
				 */
				formatUSPhone: function(number){
					var regEx = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/,
						parts = number.split(regEx);
					
					return '(' + parts[1] + ') ' + parts[2] + '-' + parts[3];
				},
				
				/**
				 * Make an absolute element be center on the browser viewport.
				 * @param {String} selector element selector.  
				 */
				makeCenter: function(selector){
					var wrapper = $(selector),
						pH = wrapper.height(),
						pW = wrapper.width(),
						win = $(window),
						ieBody = ((document.compatMode && document.compatMode !== 'BackCompat') ? document.documentElement : document.body),
						scrollTop = jsface.browser.ie ? ieBody.scrollTop : window.pageYOffset,
						winW = win.width(),
						winH = win.height(),
						top = scrollTop + (winH - pH)/2,
						left = (winW - pW)/2;

					wrapper.css({ position: 'absolute', top: (top < 0 ? 5 : top) + 'px', left: (left < 0 ? 5 : left) + 'px' });
				},

				/**
				 * jQuery activation confirmation
				 */
				renderActivationConfirmation: function(wrapper, insert_element, insert_method, hide_arr, disable_arr, remove_arr){
					// TODO Render msg to wrapper
					var promptEmailPermission = AL.Profile.social_network == "facebook" && AL.Profile.email_verified != "1",
						template,
						log = AL.Logger,
						callback = function(template){
							if(insert_method === "prepend") {
								$(insert_element, wrapper).prepend(template);
							} else {
								$(insert_element, wrapper).append(template);
								$(".status_pending_info", wrapper).css({"margin-top":"10px"});
							}

							$(".resend_verification", wrapper).unbind('click').bind('click', function() {
								var th = $(this);
								$(".link_wrapper", wrapper).html("Sending verification email...").removeClass("resend_verification").unbind('click');
								$.post("/ajax/send_verification_email",
									function(data){
										$(".link_wrapper", wrapper).html(data);
								});
							});

							$(".enable_fb_email_access", wrapper).unbind('click').bind('click', function() {
								var th = $(this);
								//alert("Open facebook enable window");
								//$.post("/ajax/enable_fb_email_access",
								//	function(data){
								//		$(".link_wrapper", wrapper).html(data);
								//});
							});                               
							jsface.wait(function(){
								return (template && template.find(".fbloggedIn_enable_email_access").length === 1);
							}, function(){
								template.find(".fbloggedIn_enable_email_access").unbind('click').bind('click', AL.app.loadingFriendStatus.getExtendedPermissions);
							}, AL.ERROR_AUTO_HIDE_DURATION);
						};

					if(AL.Profile.status !== "active" || AL.Profile.facebook_status === "pending" || promptEmailPermission) {
						$.each(hide_arr, function(index, value) {
								$(value, wrapper).addClass('hidden');
						});
						$.each(disable_arr, function(index, value) {
								$(value, wrapper).addClass('disabled');
						});
						$.each(remove_arr, function(index, value) {
								$(value, wrapper).remove();
						});
						if($(".status_pending_info", insert_element).length < 1) {
							if ( promptEmailPermission ) {
								template = AL.Utils.getTemplate(AL.LOGGED_IN_NOEMAIL_CONT, AL.LOGGED_IN_NOEMAIL, callback);
							} else if (AL.Profile.facebook_status === "pending") {
								template = AL.Utils.getTemplate(AL.STATUS_PENDING_CONT, AL.FB_STATUS_PENDING_TEMPLATE_URL, callback);
							} else {
								template = AL.Utils.getTemplate(AL.STATUS_PENDING_CONT, AL.STATUS_PENDING_TEMPLATE_URL, callback);
							}
						}
					}
				} /* end renderActivationConfirmation */

			};
		}
	});

})();