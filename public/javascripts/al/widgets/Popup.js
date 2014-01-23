/**
 * Popup.js - Popup class.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * Popup represents popup root class which is extended by classes like TryPopup, LikePopup, ContactPopup.
 * The popup is designed with a static template DOM structure which is pulled down from server and attached to the bottom of <body/>.
 *
 * @alias AL.widgets.Popup
 * @name AL.widgets.Popup
 * @test test/AL.widgets.PopupTest.js
 * @class Base popup class, extended by all popups
 * @param {Map} opts popup parameters.
 *
 * @author Tan Nhu - initial API and implementation
 * @author Eugene Goldin - destroy method and auto positioning
 */
(function(){
	var log = AL.Logger,
		popups = {};     // Map contains all instances of Popup (and its sub-classes). Format: { id: instance }

	jsface.def({
		cls: 'Popup',
		on: AL.widgets,
		init: function(){
			AL.widgets.Popup.instances = popups;
		},
		statics: [ 'getTemplate', 'hideAll' ], // Static methods
		as: function(){
			var	activeId = null,    // Active popup id
				ajax;               // Ajax indicator

			return {
				/**
				 * Popup constructor
				 * @lends AL.widgets.Popup
				 * @param {Map} opts popup parameters.
				 * @returns {AL.widgets.Popup}
				 * @constructs
				 */
				Popup: function(opts){
					// Merge options with default
					this.opts = jsface.merge({
						adjustTop: 0,
						adjustLeft: 0,
						autoShow: true,
						align: 'left',        // Popup alignment: 'left', 'right'
						anchorEvent: 'click', // Event on anchor to show the popup (click, mouseenter, etc.)
						closeOnLeave: false,  // true: when mouse is out of the popup and anchor, close it
						template: null,       // Global template for the popup (i.e: ContactPopup template). Set up per sub-class
						buttons: [],           // Declarative buttons
						onShow: jsface.emptyFn,
						onHide: jsface.emptyFn
					}, opts);

					// Bind events to anchor
					this.bindAnchorEvents();

					// Generate a unique id for this instance
					this.opts.id = AL.Utils.genId('popup');

					// Wrapper is the first and the only children of the template which contains data
					// (template does not have data itselft but only the wrapper)
					this.opts.wrapper = this.opts.template.children(':first-child');

					// Save the instance to popups
					popups[this.opts.id] = this;

					// autoShow is set: show the popup
					if (this.opts.autoShow === true) {
						this.show();
					}
				},

				/**
				 * Get the widget template. Load template into the page if it does not exist.
				 * @param templateId DOM id of the template, without '#'.
				 * @param templateUrl Template url.
				 * @param onDone function to be called when template is ready (optional).
				 * @returns jQuery object of the template on the page.
				 * @static
				 */
				getTemplate: function(templateId, templateUrl, onDone){
					return AL.Utils.getTemplate(templateId, templateUrl, onDone);
				},

				/**
				 * Hide all showing popups.
				 * @static
				 */
				hideAll: function(){
					if (activeId){
						popups[activeId].hide();
					}
				},

				/**
				 * Render data into the template.
				 */
				renderData: function(){
					var	opts = this.opts, wrapper = opts.wrapper, th = this,
						buttonsBar = wrapper.find('.popup-container-content > .butbtons-bar');

					if (buttonsBar.length){
						// Delete current content
						buttonsBar.html('');

						// Reverse order of opts.buttons: Make sure prependTo work correctly
						if ( !opts.reversedButtons){
							opts.buttons.reverse();
							opts.reversedButtons = true;
						}

						// Add declared buttons to buttons bar
						jsface.each(opts.buttons, function(index, name){
							var label = jsface.trim(name).replace(/\-/g, ' '), round = (name !== 'cancel') ? ' bt-round' : '';
							label = label.replace(/trylist/g, 'TryList');
							label = label.charAt(0).toUpperCase() + label.substring(1, label.length);

							$('<a class="bt-' + name + round + '"><span>' + label + '</span></a>').prependTo(buttonsBar).bind('click', function(){
								var fnName = 'on' + jsface.camelcase(name), fn = th[fnName];
								if (jsface.isFunction(fn)){
									fn(th); // Note: Callback is invoked under button context, need to pass component as th
								} else {
									log.warn('Popup:', fnName, 'is not declared.');
								}
							});
						});

						// Add ajax indicator and a clear element at the end of buttons bar
						ajax = $('<span class="ajax-indicator" /><span class="clear" />').appendTo(buttonsBar).eq(0);

						// Patch: Cancel position on IE7
						if (jsface.browser.ie){
							$('.popup-container .bt-cancel').css('position', 'relative');
							$('.popup-container .bt-cancel span').css({ position: 'absolute', top: (jsface.browser.ie8 ? '-4px' : '0px') });
						}
					}
				},

				/**
				 * Place holder for sub-classes to bind events to template objects related to anchor.
				 */
				bindEvents: jsface.emptyFn,

				/**
				 * Bind anchor event.
				 */
				bindAnchorEvent: function (e){
					var popup = e.data.popup;
					e.preventDefault();
					if ( !popup.preventShow){
						popup.show();
					}
					e.stopPropagation();
				},

				/**
				 * Adjust popup position.
				 */
				adjustPosition: function(){
					/* Calculate position of the pop up */
					var opts = this.opts;
					var template = opts.template;
					var anchor = $('#' + opts.anchor);
					var w = anchor.width();
					var h = anchor.height();
					var padX = 0, padY = 0;

					// On IE, 'auto' attribute will cause a NaN issue, need more work
					var padsX = [parseInt(anchor.css('padding-left')), parseInt(anchor.css('padding-right')),
								parseInt(anchor.css('margin-left')), parseInt(anchor.css('margin-right')),
								parseInt(anchor.css('border-left')), parseInt(anchor.css('border-right'))];
					var padsY = [parseInt(anchor.css('padding-top')), parseInt(anchor.css('padding-bottom')),
								parseInt(anchor.css('margin-top')), parseInt(anchor.css('margin-bottom')),
								parseInt(anchor.css('border-top')), parseInt(anchor.css('border-bottom'))];
					jsface.each(padsX, function(index, value){
						padX += isNaN(value) ? 0 : value;
					});
					jsface.each(padsY, function(index, value){
						padY += isNaN(value) ? 0 : value;
					});


					var offset = this.opts.useOffsetCaching === true ? this.opts.correctOffset(anchor.offset(), this.opts) : anchor.offset(),
								top, left;

					var viewport = {
						top: $(window).scrollTop(),
						left: $(window).scrollLeft(),
						width: $(window).width(),
						height: $(window).height()
					};

					if ( !offset) {
						log.warn('offset of', anchor, 'does not exist');
						return;
					}

					// Support left or right alignment
					if (opts.align === 'left') {
						top = (offset.top + h + padY + opts.adjustTop) + 'px';
						left = (offset.left + opts.adjustLeft) + 'px';
						this.positioned('left');
					// Auto Align
					} else if (opts.align === 'auto') {
						var tempWid = $(template).outerWidth();
						var tempHgt = $(template).outerHeight();
						var anchWid = $(anchor).outerWidth();
						var anchHgt = $(anchor).outerHeight();
						top = offset.top + anchHgt + opts.adjustTop;
						left = offset.left + ((anchWid - $(anchor).width())/2) + opts.adjustLeft;
						if (left + tempWid > viewport.left + viewport.width &&
							offset.left - tempWid + (anchWid/2) + ($(anchor).width()/2) + opts.adjustLeft > viewport.left) {
							// if the popup goes to the right of the page, and if we face
							// it left and it does not go to the left of the page
							left = offset.left - tempWid + (anchWid/2) + ($(anchor).width()/2) + opts.adjustLeft;
							this.positioned('left');
						} else {
							this.positioned('right');
						}

					// Right Align
					} else {
						top = (offset.top + h + padY + opts.adjustTop) + 'px';
						left = (offset.left + padY - template.width() + w +  opts.adjustLeft) + 'px';
						this.positioned('right');
					}

					template.css({ top: top, left: left });
				},

				/**
				 * Abstract method
				 * called when position is set with the given alignment
				 */
				positioned: function(pos){},

				/**
				 * Show the popup.
				 */
				show: function(){
					var toggle, opts;

					toggle = false;
					opts = this.opts;

					// If activeId is instance id, toggle the popup
					if (opts.id === activeId){
						// If it is visible, hide it
						if (opts.template.css('display') != 'none'){
							return this.hide();
						}
					} else if (activeId !== null) { // There is one instance is showing up, hide it first before showing up
						var activePopup = popups[activeId];
						activePopup.hide();
					}

					// If not toggle, do fill data and bind events, then show up
					this.renderData();
					this.bindEvents();
					opts.template.appendTo('body').css({ display: 'block' });
					opts.onShow(this);

					// Update activeId
					activeId = this.opts.id;

					// Adjust position
					this.adjustPosition();

					// Save popup, use in event contexts
					var popup = this;
					var anchor = $('#' + popup.opts.anchor);
					var entering = null;
					var stopPropagation = AL.Utils.stopPropagation;

					var hideFn = function(e){
						log.warn('fbindex' + $(e.target).attr('id').indexOf("fb_"));
						if( $(e.target).attr('id').indexOf("fb_") != 0 ) {
						  $(document).unbind('click', hideFn);
						  popup.opts.wrapper.unbind('mouseenter', mouseEnter).unbind('mouseleave', mouseLeave).unbind('click', stopPropagation);
						  anchor.unbind('mouseenter', mouseEnter).unbind('mouseleave', mouseLeave).unbind('mousedown', stopPropagation);
						  opts.template.css({ display: 'none' });
						  entering = null;
						  opts.template.unbind(opts.id);
						  popup.hide();
						}
					};

					var mouseEnter = function(e){
						$(document).unbind('click', hideFn);
						entering = true;
					};

					var mouseLeave = function(e){
						$(document).bind('click', hideFn);
						entering = false;
					};

					// Bind mouseenter and mouseleave to wrapper and anchor
					opts.wrapper.bind('mouseenter', mouseEnter).bind('mouseleave', mouseLeave).bind('click', stopPropagation);
					anchor.bind('mouseenter', mouseEnter).bind('mouseleave', mouseLeave).bind('mousedown', stopPropagation);

					// Bind a custom event to hide and unbind bound events to template
					// This event is triggered and cleared by hide()
					opts.template.bind(opts.id, hideFn);

					// Bind resize event: when window resizes, close the popup
					$(window).bind('resize', function adjustPosition(){
						popup.adjustPosition();
					});

					// If closeOnLeave is set, popup will be closed when mouse is out of the popup and anchor
					if (opts.closeOnLeave === true){
						// IE fires mousemove before mouseenter, need to stop it by stopPropagation
						anchor.bind('mousemove', stopPropagation);
						opts.wrapper.bind('mousemove', stopPropagation);

						var closeOnLeaveFn = function(e) {
							if (entering === false && opts.closeOnLeave === true){
								entering = null;
								$(document).unbind('mousemove', closeOnLeaveFn);
								anchor.unbind('mousemove', stopPropagation);
								opts.wrapper.unbind('mousemove', stopPropagation);
								hideFn();
							}
						};
						$(document).bind('mousemove', closeOnLeaveFn);
					}

					// Hide ajax indicator (if it is there)
					this.hideAjax();
				},

				/**
				 * Hide the popup.
				 */
				hide: function(){
					// Trigger the event bound by show(), then remove it
					var opts = this.opts;
					opts.template.trigger(opts.id).unbind(opts.id);
					opts.onHide(this);
				},

				/**
				 * Bind events to anchor.
				 */
				bindAnchorEvents: function(){
					$('#' + this.opts.anchor).bind(this.opts.anchorEvent, { popup: this }, this.bindAnchorEvent);
				},

				/**
				 * Show ajax indicator.
				 */
				showAjax: function(){
					if (ajax){
						if (jsface.browser.ie7){
							ajax.css({ display: 'inline-block', right: '12px', bottom: '12px' });
						} else {
							ajax.show();
						}
					}
				},

				/**
				 * Hide ajax indicator.
				 */
				hideAjax: function(){
					if (ajax){
						ajax.hide();
					}
				},

				/**
				 * Unbind events and destroy the popup
				 * All external references MUST be removed outside of this method
				 * -as we do not have access to them here- otherwise the memory will
				 * not be reclaimed
				 */
				destroy: function() {
					var opts = this.opts,
						anchor = $('#' + this.opts.anchor);

					// hide the popup, and prevent it from being shown again.
					this.show = function(){};

					// unbind events
					opts.template.trigger(opts.id).unbind(opts.id);
					$('#' + this.opts.anchor).unbind(this.opts.anchorEvent, this.bindAnchorEvent);

					// remove reference from the popups global array
					delete popups[this.opts.anchor];
				}
			};
		}/*,
		pointcuts: { // Experiment shadow. TODO: Ask Sila for our own shadow images
			show: {
				after: function(){
					var opts = this.opts, wrapper = opts.wrapper, shadow;

					function bindShadow(){
						shadow = $('<div id="popup-shadow-alpha" style="background: transparent url(/images/beta2/shadowAlpha.png) bottom right;"></div>').width(wrapper.width()).height(wrapper.height());
						$('#popup-shadow-alpha').remove();
						shadow.css({
							position: 'absolute',
							top: wrapper.offset().top + 15,
							left: wrapper.offset().left + 5
						});
						opts.template.before(shadow);
						AL.Logger.debug('here');
					}
					opts.bindShadow = bindShadow;
					if (opts.shadow !== false){
						bindShadow();
					}
				}
			},
			hide: {
				before: function(){
					if (this.opts.shadow !== false){
						$('#popup-shadow-alpha').remove();
						this.opts.wrapper.unbind('resize', this.opts.bindShadow);
					}
				}
			}
		}*/
	});

	/**
	 * Parameter validation pointcuts. ON A VERY STABLE SYSTEM: This can be removed to get more speed!
	 */
	jsface.pointcuts({
		on: AL.widgets.Popup,
		as: {
			Popup: {
				before: function(opts){
					var passed = true;

					if ( !jsface.isMap(opts)){
						log.warn("Popup: Invalid constructor parameter.");
						passed = false;
					}

					var len = $('#' + opts.anchor).length;
					if (len !== 1){
						log.warn("Popup: Invalid binding anchor #" + opts.anchor + ". It must be existed or unique. Found: " + len + " item(s).");
						passed = false;
					}

					if (jsface.isNullOrUndefined(opts.template)){
						log.error('Popup: Invalid parameter. opts.template must point to a template.');
						passed = false;
					}

					return passed;
				},
				after: function(opts){
				}
			}
		}
	});

})();