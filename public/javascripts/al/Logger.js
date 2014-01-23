/**
 * AL.ui.Logger.js - Logging Singleton Class.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * @class Logging application
 * @name AL.Logger
 * @author Tan Nhu - initial API and implementation
 */
(function(){
	/**
	 * Logger is singleton class supports logging functions. Global logging level is
	 * set on AL.Config.js as AL.LOG_LEVEL.
	 *
	 * @alias AL.Logger
	 * @test test/AL.LoggerTest.js
	 */
	jsface.def({
		cls: 'Logger',
		on: AL,
		singleton: true,
		as: function()
		/** @lends AL.Logger */
		{
			// To make sure logger class available even when DOM is NOT ready, save
			// log message in an internal structure. When DOM is ready, push them out
			var logs = { info: [], warn: [], debug: [], error: [], fatal: []};
			var logFn = function(type, args){
				logs[type].push(args);
			}

			// Temporary logging methods (DOM is not ready)
			var fn = {
				info: function(){
					logFn('info', arguments);
				},
				warn: function(){
					logFn('warn', arguments);
				},
				debug: function(){
					logFn('debug', arguments);
				},
				error: function(){
					logFn('error', arguments);
				},
				fatal: function(){
					logFn('fatal', arguments);
				}
			}

			/**
			 * Select logging method based on AL.LOG_LEVEL (I.e: if the config level is 'error',
			 * just error and fatal messages are logged).
			 */
			var selectFn = function(logFnName, fn){
				var levels = [ 'info', 'warn', 'debug', 'error', 'fatal', 'none' ];
				var configIndex;
				var logFnIndex;
				jsface.each(levels, function(index, level){
					if (AL.LOG_LEVEL === level){
						configIndex = index;
					}
					if (logFnName === level){
						logFnIndex = index;
					}
				});

				return (logFnIndex >= configIndex) ? fn : jsface.emptyFn;
			}

			// Override logging methods when DOM is ready
			$(document).ready(function initLogger(){
				// Use firebug logging if Firebug exists, otherwise, use jQuery log plugin
				var firebug = (window.console && window.console.element && window.console.element.id === '_firebugConsole');
				var log = (window.console && window.console.log) ? window.console.log : (window.opera ? window.opera.postError : jsface.emptyFn);

				// Chrome and Safari don't allow to point to window.console.log
				if (jsface.browser.chrome || jsface.browser.safari){
					log = function(){
						console.log.apply(console, arguments);
					}
				}

				var fn = AL.Logger;

				fn.info = selectFn('info', firebug ? window.console.log : log);
				fn.warn = selectFn('warn', firebug ? window.console.warn : log);
				fn.debug = selectFn('debug', firebug ? window.console.debug : log);
				fn.error = selectFn('error', firebug ? window.console.error : log);
				fn.fatal = selectFn('fatal', firebug ? window.console.error : log);

				// Execute logging methods for caching logs
				jsface.each(logs, function(key, args){
					jsface.each(args, function(index, arg){
						if (jsface.browser.ie){
							fn[key](arg);
						} else {
							fn[key].apply(AL.Logger, arg);
						}
					});
				});

				// Release memory
				logs = null;
			});

			return fn;
		}
	});
})();