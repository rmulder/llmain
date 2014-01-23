/**
 * AL.Tracker.js - Tracking Singleton Class.
 *
 * Copyright (c) 2010 Alikelist, Inc. All rights reserved.
 *
 * @class Event tracking application
 * @name AL.Tracker
 * @author Eugene Goldin - initial API and implementation
 */

/**
 * Google analytics queue - needs to be a global variable!
 */
var _gaq = _gaq || [];

(function(){
	jsface.def({
		cls: 'Tracker',
		on: AL,
		singleton: true,
		as: function()
		/** @lends AL.Tracker */
		{
			// private constants
			var GOOGLE = 'gat',
				GOOGLE_TRACKER_ID = {
					AL: 'UA-9974337-1', 
					SMB: 'UA-9974337-6'
				};
			
			/**
			 * Cache the events triggered before the tracker has been loaded
			 */
			var cache = [];
			
			/**
			 * Faux tracking function, used until the tracker has loaded. This places
			 * the tracks into the {@link cache} above.
			 * @param {String} page - the page value to track
			 * @param {Object} args - <br />
			 * 				args.type - event type<br />
			 * 				args.pageview - superceedes the first page param
			 */
			var cacheTrack = function(page, args){
				args = $.extend({
					type: AL.Tracker.PAGE_VIEW,
					pageview: page
				}, args);
				cache.push(args);
			};
			var domready = false;
			var trackers = {};

			/**
			 * Track
			 * Generic tracking function capable of managing several js trackers
			 * @param {string} page - overwritten by pageview in args
			 * @param {object} args - contains options / generic arguments that are
			 * 						used in tracking:<br />
			 * 			- type: action type, defined with external 
			 * 					constants in initialClass<br />
			 * 			- pageview: page 'url' string to track 
			 * 					(if none provided tracks current page)
			 */
			var trackFn = function(page, args) {
				var ts = {};
				
				// accept 'args' in first or second input
				if (typeof page === 'object') {
					args = page;
					page = undefined;
				}
				
				// add necessary defaults
				args = $.extend({
					type: AL.Tracker.PAGE_VIEW,
					pageview: page,
					trackers: trackers
				}, args);
				
				// google async tracking
				for (var idx in args.trackers) {
					if (args.pageview) {
						_gaq.push([args.trackers[idx] + '._trackPageview', args.pageview]);
					} else {
						_gaq.push([args.trackers[idx] + '._trackPageview']);
					}
					AL.Logger.info('AL.Tracker[' + args.trackers[idx] + '] tracks ', args);
				}
			};

			/**
			 * Load external trackers
			 * Currently only have google analytics, so init tracker 
			 * does not need to keep track of which trackers have been loaded
			 * before beginning to track
			 */
			$.ajax({
				url: (("https:" === document.location.protocol) ? "https://ssl." : "http://www.") + 'google-analytics.com/ga.js',
				dataType: 'script',
				success: function() {
					if (domready) {
						// only if the google analytics script loads after dom
						initTracker();
					}
				}
			});
			
			/**
			 * On document ready, initialize the trackers
			 */
			$(document).ready(function() {
				domready = true;
				initTracker();
			});

			/**
			 * Initialize tracker
			 * Currently only supporting the google analytics tracker
			 */
			function initTracker() {
				// initialize google ajax tracker
				if (_gaq && _gaq._createAsyncTracker) {
					try {
						if ($('body').hasClass('smb')) {
							trackers.SMB = AL.Tracker.TRACKERS.SMB;
							_gaq._createAsyncTracker(GOOGLE_TRACKER_ID.SMB, trackers.SMB);
							AL.Logger.info('Initialized', trackers.SMB, ':', GOOGLE_TRACKER_ID.SMB);
						} 
						trackers.AL = AL.Tracker.TRACKERS.AL;
						_gaq._createAsyncTracker(GOOGLE_TRACKER_ID.AL, trackers.AL);
						AL.Logger.info('Initialized', trackers.AL, ':', GOOGLE_TRACKER_ID.AL);

					} catch(e) {
						AL.Logger.warn('Google analytics failed to load (or is still loading)');
						return;
					}
				} else {
					return;
				}
				
				// Set up new tracking function
				AL.Tracker.track = trackFn;

				// Execute tracking methods for cached tracks
				jsface.each(cache, function(key, args){
					trackFn(args);
				});

				// Release memory
				delete cache;
			}
			
			/**
			 * Initial public functions and constants
			 */
			return {
				/**
				 * Initial tracking function, overwritten by {@link trackFn} once
				 * the trackers have been loaded
				 */
				track: function(args){
					cacheTrack(args);
				},
				
				/**
				 * Track type
				 * @const
				 */
				CLICK_VIEW: 'click view',
				
				/**
				 * Track type
				 * @const
				 */
				CLICK_ACTION: 'click action',
				
				/**
				 * Track type
				 * @const
				 */
				DRAG_ACTION: 'drag action',
				
				/**
				 * Track type
				 * @const
				 */
				PAGE_VIEW: 'page view',
				
				/**
				 * Tracker object containing tracking namespaces
				 * @const
				 */
				TRACKERS: {
					/**
					 * Alikelist base tracker
					 */
					AL: 'alTracker',
					
					/**
					 * SMB tracker
					 */
					SMB: 'smbTracker'
				}
			};
		}
	});
})();