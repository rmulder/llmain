/**
 * AL.tools.Google.js - Alikelist interation with Google.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * @author Tan Nhu - initial API and implementation
 * @class Alikelist interation with Google.
 * @name AL.tools.Google
 */
(function(){

	jsface.def({
		cls: 'Google',
		on: AL.tools,
		singleton: true,
		as: function()
		/** @lends AL.tools.Google */
		{
			/**
			 * Submit Conversion to Google by making an image request with all conversion parameters in its url.
			 *
			 * Dev Notes: We can make this conversion tracking by both JavaScript approach (declare Gooogle
			 * global variables, then include their script (www.googleadservices.com/pagead/conversion.js)) or
			 * just make a request to their 1x1 gif transparent image with all conversion parameters inside
			 * the URL. The second approach is better as: No third party code, no CPU consuming for external
			 * script, no third party global variables, seamless working flow (load the image then do a redirect
			 * and being sure that the request was made).
			 *
			 * @param imgSrc {String} conversion image source (with params).
			 */
			function submitConversion(imgSrc){
				if ( !jsface.isEmpty(imgSrc) && jsface.isString(imgSrc)){
					new Image().src = imgSrc;
				}
			}

			return {
				/**
				 * Submit Claimed SMB Conversion.
				 */
				submitClaimedSMBConversion: function(){
					submitConversion('http://www.googleadservices.com/pagead/conversion/1027467554/?label=YpODCIzZwQEQotL36QM&amp;guid=ON&amp;script=0');
				},

				/**
				 * Submit Get Started Process Conversion.
				 */
				submitGetStartedProcessConversion: function(){
					submitConversion('http://www.googleadservices.com/pagead/conversion/1027467554/?label=htVGCMDawQEQotL36QM&amp;guid=ON&amp;script=0');
				},

				/**
				 * Submit Paid Account Conversion. Very first time entering CC.
				 */
				submitPaidAccountConversion: function(){
					submitConversion('https://www.googleadservices.com/pagead/conversion/1027467554/?value=19.95&amp;label=dDb2CNjXwQEQotL36QM&amp;guid=ON&amp;script=0');
				}
			};
		}
	});

})();