/**
 * AL.tools.Twitter.js - Alikelist interation with Twitter.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * @class Alikelist interation with Twitter
 * @name AL.tools.Twitter
 * @requires jsface
 * @requires AL.Logger
 *
 * @author Tan Nhu - initial API and implementation
 */
(function(){
	var log = AL.Logger;
	
	jsface.def({
		cls: 'Twitter',
		on: AL.tools,
		singleton: true,
		as: function()
		/** @lends AL.tools.Twitter */
		{
			var successFn, failureFn;
			
			return {
				/**
				 * Connect to Twitter.
				 * @param success {Function} success callback (permission granted). Optional.
				 * @param failure {Function} failure callback. Optional.
				 */
				connect: function(success, failure){
					successFn = jsface.isFunction(success) ? success : jsface.emptyFn;
					failureFn = jsface.isFunction(failure) ? failure : jsface.emptyFn;
					
					// Open popup window for OAuth grant. Please note that the script in callback url will
					// be responsible to update connect status and invoke logic after all by calling
					// window.opener.AL.tools.Twitter.grantPermission() 
					window.open(AL.TWITTER_CONNECTOR_URL, 
							'OAuthTwitterWindow', 
							'menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes,width=800,height=400');
				},
				
				/**
				 * Callback function which Twitter callback document used to invoke main document after all.
				 * @param perm {Boolean} true or false. True means user granted permission to read and write
				 * to his/her Twitter account.  
				 */
				grantPermission: function(perm){
					if (perm == true || perm == 1){
						log.debug('Twitter user granted permission to read and write.');
						successFn();
					} else {
						log.debug('Twitter user prohibited permission to read and write. perm = ' + perm);
						failureFn();
					}
				}
			}
		}
	});

})();