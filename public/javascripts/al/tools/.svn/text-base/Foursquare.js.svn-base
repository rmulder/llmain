/**
 * AL.tools.Foursquare.js - Alikelist interation with Foursquare.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * @class Alikelist interation with Foursquare
 * @name AL.tools.Foursquare
 * @requires jsface
 * @requires AL.Logger
 *
 * @author Robert Mulder - initial API and implementation
 */
(function(){
	var log = AL.Logger;
	
	jsface.def({
		cls: 'Foursquare',
		on: AL.tools,
		singleton: true,
		as: function()
		/** @lends AL.tools.Foursquare */
		{
			var successFn, failureFn;
			
			return {
				/**
				 * Connect to Foursquare.
				 * @param success {Function} success callback (permission granted). Optional.
				 * @param failure {Function} failure callback. Optional.
				 */
				connect: function(success, failure){
					successFn = jsface.isFunction(success) ? success : jsface.emptyFn;
					failureFn = jsface.isFunction(failure) ? failure : jsface.emptyFn;
					
					// Open popup window for OAuth grant. Please note that the script in callback url will
					// be responsible to update connect status and invoke logic after all by calling
					// window.opener.AL.tools.Foursquare.grantPermission() 
					window.open(AL.FOURSQUARE_CONNECTOR_URL, 
							'OAuthFoursquareWindow', 
							'menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes,width=900,height=450');
				},
				
				/**
				 * Callback function which Foursquare callback document used to invoke main document after all.
				 * @param perm {Boolean} true or false. True means user granted permission to read and write
				 * to his/her Foursquare account.  
				 */
				grantPermission: function(perm){
					if (perm == true || perm == 1){
						log.debug('Foursquare user granted permission to read and write.');
						successFn();
					} else {
						log.debug('Foursquare user prohibited permission to read and write. perm = ' + perm);
						failureFn();
					}
				}
			}
		}
	});

})();