/**
 * AL.tools.Aria.js - Alikelist interation with Aria Payments.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * @author Tan Nhu - initial API and implementation
 * @class Alikelist interation with Aria Payments
 * @name AL.tools.Aria
 */
(function(){

	jsface.def({
		cls: 'Aria',
		on: AL.tools,
		singleton: true,
		as: function()
		/** @lends AL.tools.Aria */
		{
			return {
				/**
				 * Inject Aria Payment IFrame.
				 * @param {int} businessId business id.
				 * @param {Function} callback. Callback is invoked as callback(aria--iframe-url).
				 * @return {String} Aria IFrame url.
				 */
				injectPaymentIFrame: function(businessId, callback){
					return;  //no longer needed
				},

				/**
				 * Build Aria IFrame markup.
				 * @param {String} src Aria IFrame source.
				 * @param {String} iframeId IFrame id (optional).
				 * @return {String} Aria IFrame markup.
				 */
				buildIFrameMarkup: function(src, iframeId){
					iframeId = iframeId ? iframeId : 'iframe-aria';
					return '<iframe id="' + iframeId +'" style="width:836px;height:465px;" src="' + src + '"></iframe>';
				}
			};
		}
	});

})();