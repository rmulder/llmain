/**
 * JoinPopup.js - Join Popup class.
 *
 * Copyright (c) 2009, 2010 Alikelist, Inc. All rights reserved.
 *
 * LoginPopup class handles login and forgot password forms for the front end.
 *
 * @alias AL.widgets.LoginPopup
 * @test test/AL.widgets.PopupTest.js
 * @name AL.widgets.LoginPopup
 * @augments AL.widgets.Popup
 * @class Login popup class
 *
 * Dependencies:
 * 	+ /css/loginPopup.css
 *
 * Developers:
 *    Jonthan Ma --- using Tan's template
 */
(function() {

    // Static logger
    var log = AL.Logger;

    jsface.def({
        cls: 'JoinPopup',
        on: AL.widgets,
        under: AL.widgets.Popup,
        as: function() {
            // Shared template for all class instances
            var template = null, proto = AL.widgets.Popup.prototype;

            // Load template when DOM is ready
            $(document).ready(function() {
                            
                // removed template autoload
                template = $('#'+AL.LOGIN_POPUP_TEMPLATE_ID); //AL.widgets.Popup.getTemplate(AL.LOGIN_POPUP_TEMPLATE_ID, AL.LOGIN_POPUP_TEMPLATE_URL);
            });
//jma test
            function toggleSignIn() {
                $("#login-popup-signIn-with-facebook").show();

                $("#signInWithYourEmail").click(function() {
                    $("#login-popup-signIn-with-facebook").hide();
                    $("#login-popup-linked-signIn").show();
                });
            }

            function showJoinContentOnly(){
                $('#login-popup-container-content').addClass('hidden');
                $('#join-popup-container-content').removeClass('hidden');
            }
            var adjust = function() {

                var cachedOffset = null;// Only relevant if you use the option: useOffsetCaching
                function isCorrect(offset) {
                    return offset.left > 0;
                }
                function cache(offset) {
                    var newOffset = {
                        left: offset.left,
                        top: offset.top
                    };
                    //  Unfortunately, we can't feature detect
                    //  Note: jQuery browser detection is deprecated
                    if(  jsface.browser.ie7 )
                        newOffset.top = parseInt(newOffset.top, 10) + 13;
                    return newOffset;
                }

                return {
                    correctOffset: function(offset, opts) {
                        if(opts !== undefined && opts.useOffsetCaching === true )
                        {
                            if( isCorrect(offset) )
                                cachedOffset = cache(offset);
                            if(!isCorrect(offset) && cachedOffset != null )
                                offset = cachedOffset;

                    }
                        return offset;
                    }
                };
            }();

            return {
                /**
				 * LoginPopup constructor.
				 * @lends AL.widgets.LoginPopup
				 * @param {Map} opts popup parameters.
				 * @return {AL.widgets.TryPopup}
				 * @constructor
				 */
                JoinPopup: function(opts) {
                    // Merge options with default
                    opts = jsface.merge({
                        adjustTop: 0,
                        adjustLeft: 0,
                        align: 'left',
                        // Support 'left' and 'right'
                        anchorEvent: 'click',
                        closeOnLeave: false,
                        template: template,
                        autoShow: false,
                        // Auto show the popup
                        defaultAvatar: AL.DEFAULT_AVATAR_URL,
                        cancelRedirect: false,
                        // Default avatar (for entries which have no avatar), i.e: '/images/no_photo.gif'
                        dataSource: function() { // Dynamic data source
                            return {
                                hiddenPass: false,
                                username: '',
                                rememberMe: false,
                                autoLogin: true,
                                queryString: '',
                                redirectPage: '',
                                iid: ''
                            };
                        },
                        // Caching data source ds = dataSource();
                        ds: null,
                        // if refreshDS is true, ds will be retrieved everytime showing the popup, otherwise, it is calculated once
                        refreshDS: false,
                        // Callback function when everything is done (i.e: After user clicks "Submit")
                        onDone: function(opts) {},
                        // Callback function when popup is hidden
                        onHide: function() {},
                        useOffsetCaching: true,
                        correctOffset: adjust.correctOffset,
                        unauthMode: false, // displays a login prompt first
                        unauthText: '' // login prompt
                    }, opts);

                    // Call super constructor
                    AL.widgets.Popup.call(this, opts);
                },

                /* @Override */
                show: function() {
                    $("#login-popup-container-wrapper").css("width","700px");

                    showJoinContentOnly();
                    var opts = this.opts;
                    proto.show.call(this);
                //setTimeout("$(\"#joinFirstName\").focus();", 100);

                },

                /* @Override */
                hide: function() {
                    var opts = this.opts;
                    proto.hide.call(this);
                    this.opts.onHide();
                    // Show reset form (incase forgot password was used)
                    this.reset();
                },

                /* @Override */
                /*renderData: function() {
					var	opts = this.opts,
						wrapper = opts.wrapper,
						ds = (opts.refreshDS === true)  ? opts.dataSource() : (opts.ds === null ? opts.ds = opts.dataSource() : opts.ds);

					// if the user has not modified the username, reset it
					if (!$('#login-popup-username').val() && !!ds.username) {
						$('#login-popup-username').val(ds.username);
					}

					// if the user has chosen to be remembered
					if (ds.hiddenPass) {
						$('#login-popup-password').val(AL.LOGIN_POPUP_HIDDEN_PASS);
					}

					//if(ds.autoLogin){
					$('#login-popup-auto-login').attr('checked', 'checked');
					//}

					if (opts.unauthMode) {
						$('#login-popup-signin-content').addClass('hidden');
						$('#login-popup-prompt-container').removeClass('hidden');
						$('#login-popup-prompt').text(opts.unauthText);
					}
					toggleSignIn();
				},
*/
                /**
				 * Reset template to original state.
				 */
                reset: function() {
                    // show proper section
                    $('#login-popup-forgotpassword-content').addClass('hidden');
                    $('#login-popup-forgotpassword-instructions').html(AL.LOGIN_POPUP_FORGOT_DEFAULT_MSG).removeClass('error');
                    $('#login-popup-form-forgotpassword').removeClass('hidden');
                    $('#login-popup-forgotpassword-not-a-member').removeClass('hidden');
                    //$('#login-popup-signin-content').removeClass('hidden');
                    $('#login-popup-prompt-container').addClass('hidden');

                    // remove old errors and hide error box
                    $('#login-popup-error').html('').addClass('hidden');
                },

                /* @Override */
                bindEvents: function() {
                    var pop = this,
                    ds = this.opts.ds;

                    // start loading facebook api (mostly for the benefit of IE)
                    AL.tools.Facebook.init(false);
                  
                    // join link
                    /*
                                        $("#join-popup-registration").unbind('click').click(function(){
						$('#login-popup-signin-content').addClass('hidden');
						$('#login-popup-container-content').addClass('hidden');
						var signInBoxPosition = $("#login-popup-container").position().left;
						$('#login-popup-container').css('left',(signInBoxPosition + 50));
						$('#join-popup-container-content').removeClass('hidden');
					});
                                        */
                    // sign in link
                    $("#signInWithYourEmail").unbind('click').click(function(){
                        var signInBoxPosition = $("#login-popup-container").position().left;
                        $('#login-popup-container').css('left',(signInBoxPosition - 50));
                        $('#login-popup-signin-content').removeClass('hidden');
                        $('#login-popup-container-content').removeClass('hidden');
                        $('#login-popup-forgotpassword-content').addClass('hidden');
                        $('#join-popup-container-content').addClass('hidden');
                    });

                    $("#zipCity_why").unbind('mouseover').mouseover(function(){
                        //alert(1);
                        $("#zipCity_tooltip").removeClass('hidden');
                    });
                    $("#zipCity_why").unbind('mouseout').mouseout(function(){
                        $("#zipCity_tooltip").addClass('hidden');
                    })

                    //JOIN submit  joinUsForm  /registration/index_new  $(form).trigger("submit");

                    // initial focus individually resets inputs to empty fields
                    $('#joinUserName').focus(function() {
                        if ($('#joinUserName').attr('value') == 'Full Name'){
                            $('#joinUserName').attr('value', '');
                        }
                    });
                    $('#joinUserName').blur(function() {
                        if ($('#joinUserName').attr('value') == ''){
                            $('#joinUserName').attr('value', 'Full Name');
                        }
                    });
                    $('#joinEmail').focus(function() {
                        if ($('#joinEmail').attr('value') == 'Email Address'){
                            $('#joinEmail').attr('value', '');
                        }
                    });
                    $('#joinEmail').blur(function() {
                        if ($('#joinEmail').attr('value') == ''){
                            $('#joinEmail').attr('value', 'Email Address');
                        }
                    });
                    $('#joinLocation').change(function(e) {
                        setCityIdField(e,$('#joinLocation').attr('value'),"");
                    });
                    $('#joinLocation').focus(function() {
                        if ($('#joinLocation').attr('value') == 'City or Zip Code'){
                            $('#joinLocation').attr('value', '');
                        }
                    });
                    $('#joinLocation').blur(function(e) {
                        if ($('#joinLocation').attr('value') == ''){
                            $('#joinLocation').attr('value', 'City or Zip Code').css('color','#f00');
                           
                        }
                    });
                    
                    //  start: location auto complete
                     /* Set city id field given 'city, state' and flush searchFor autocomplete cach
                     *
                     * @param event		generic event object, included for the benefit of the autocomplete plugin
                     * @param data		selected data, can be a plain string value or an array or object.
                     *					(included for the benefit of the autocomplete plugin)
                     * @param formatted formatted value (taken from the input) to be used in the lookup
                     */
                    var setCityIdField = function(event, data, formatted){
							data = "" + data;
							var arr_data = data.split(/<|>/);
							var city_id = "",city_string = "";
							if(arr_data.length > 0)
								city_string = arr_data[0];
							if(arr_data.length > 3)
								city_id = arr_data[2];
													
							$('#joinLocation').val(city_string);
							$('#joinCityId').val(city_id);
							
							return false;
                    };

                    $('#joinLocation').autocomplete(
                                '/ajax/list_zipcity',
                                {
                                    delay: 0,
                                    max: 100,
                                    minChars: 1,
                                    cacheLength: 0
                                }).result( setCityIdField);
                    
                    // End of location auto complete

                    //alert('Handler for .focus() called.');

                    // join validator
                    if(!pop.joinValidator){
                        pop.joinValidator = $('#joinUsForm').validate({
                            rules: {
                                "data[full_name]": "required",
                                "data[email_id]": {
                                    required: true,
                                    email: true
                                },
                                "data[password]": {
                                    required: true,
                                    minlength: 6,
                                    maxlength: 12
                                //validPassword: "valid password required"// /^([^ ]{6,12})$/
                                },
                                "data[location]": {
                                    required: true,
                                    minlength: 5,
                                    maxlength: 100
                                	//remote: "/ajax/citystate/" + "#data[zip]"
                                }
                                //"data[location]":  "required"
                            },
                            messages: {
                                "data[full_name]": "Please enter a full name",
                                "data[email_id]": {
                                    required:"Please enter email address",
                                    email:"Please enter valid email address"
                                },
                                "data[password]":	{
                                    required: "Password required",
                                    minlength: "Your password must be at least 6 characters long",
                                    maxlength: "Your password must be no longer than 12 characters"
                                },
                                "data[location]":		{
                                    required: "Location required",
                                    minlength: "Location should be at least 5 digits long",
                                    maxlength: "Location should be no longer than 100 characters"
                                }
                                //"data[location]":	{
                                //    required: "Location required"
                                //}
                            },
                            submitHandler: function(form){
                                $(".join_loading_gif").css({
                                    "display": "block"
                                });
                                $('#join-popup-error').addClass('hidden');
                                var dataString = $("#joinUsForm").serialize();
                                $.ajax({
                                    type: "POST",
                                    url: "/registration/index_new",
                                    data: dataString,
                                    dataType: "json",
                                    success: function(data) {
                                        if (data.code === 100) {
                                            document.location = "/home";
                                        } else if (data.code === 0) {
                                            // show in general error div
                                            $('#join-popup-error').removeClass('hidden');
                                            $('#join-popup-error').html(data.message);
                                            //$('#join-popup-signin-content').css('height','445px');
                                            $(".join_loading_gif").css({
                                                "display": "none"
                                            });
                                        } else {
                                            //missed element
                                            alert("join popop ajax return code:" + data.code);
                                        }
                                    }

                                });

                                //doJoin(pop);
                                return false;
                            }
                        });
                    }

                    // submit Join
                    $('#joinFormButton').unbind('click').click(function(){
                        $('#joinUsForm').submit();
                    });

                    $('#joinUsForm').keypress(function(e) {
                        if (e.which == AL.ENTER_KEY) {
                            $('#joinUsForm').submit();
                        }
                    });

                    // close on facebook
                    $('.banner_facebook_signin', this.opts.wrapper).click(function() {
                        AL.tools.Facebook.connect(undefined, $('#login-popup-auto-login').attr('checked'), function() {
                            pop.opts.onDone(pop.opts);
                        });
                        pop.hide();
                        $.cookie("login", "true");
                    });

                    // x button
                    $('.popup-container-header-close', this.opts.wrapper).unbind('click').click(function(ev){
                        pop.hide();
                    });

                    // unauth mode
                    //$('#login-popup-prompt-link', this.opts.wrapper).unbind('click').bind('click', function(){
                    //    $('#login-popup-signin-content').removeClass('hidden');
                    //    $('#login-popup-prompt-container').addClass('hidden');
                    //});
                },
                /* @Override */
                positioned: function(pos){
                    if (this.opts.align === 'right') {
                        pos = 'left';
                    }

                    if (pos === 'left') {
                        $('.popup-container-header-carrot', this.opts.wrapper).css({
                            right: 15,
                            left: 'auto'
                        });
                    } else {
                        $('.popup-container-header-carrot', this.opts.wrapper).css({
                            left: 15,
                            right: 'auto'
                        });
                    }
                }
            };
        }
    });

})();
