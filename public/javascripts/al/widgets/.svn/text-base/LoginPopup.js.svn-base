/**
 * LoginPopup.js - Login Popup class.
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
 *    Eugene Goldin - using Tan's template
 */
(function() {

    // Static logger
    var log = AL.Logger;

    jsface.def({
        cls: 'LoginPopup',
        on: AL.widgets,
        under: AL.widgets.Popup,
        as: function() {
            // Shared template for all class instances
            var template = null,
            savedMyList,
            proto = AL.widgets.Popup.prototype;

            // Load template when DOM is ready
            $(document).ready(function() {
                // removed template autoload
                template = $('#'+AL.LOGIN_POPUP_TEMPLATE_ID); //AL.widgets.Popup.getTemplate(AL.LOGIN_POPUP_TEMPLATE_ID, AL.LOGIN_POPUP_TEMPLATE_URL);
            });

            // Private Login functions

            function doForgotPwd(){
                $('#login-popup-form-forgotpassword').addClass('hidden');
                $('#login-popup-forgotpassword-not-a-member').addClass('hidden');

                var emailID = $('#login-popup-forgotpassword-email').val();
                $('#login-popup-forgotpassword-instructions').html('Checking...');
                $('#login-popup-forgotpassword-email').val('');
                $.post(AL.LOGIN_POPUP_SUBMIT_FORGOT_URL, {
                    emailID: emailID
                },
                function(ajaxdata) {
                    var data = $.evalJSON(ajaxdata);
                    if(data.error>1){
                        var msg = '';
                        // this switch should be replaced by data.msg when that is available
                        switch(data.error){
                            case 2:
                                msg = 'Sorry, we couldn\'t find that sign in ID.<br />Please check your entry to make sure you typed it correctly.';
                                break;
                            case 3:
                                msg = 'New Password is not sent because of some problem.';
                                break;
                            case 4:
                                msg = 'Please activate your account. Activation key is sent to your email address.';
                                break;
                            case 5:
                                msg = 'Please enter your email address';
                                break;
                            default:
                                msg = 'Unknown error occured.';
                        }
                        $('#login-popup-forgotpassword-instructions').addClass('error').html(msg);
                        $('#login-popup-form-forgotpassword').removeClass('hidden');
                        $('#login-popup-forgotpassword-not-a-member').removeClass('hidden');
                    } else {
                        $('#login-popup-forgotpassword-instructions').removeClass('error').html('Your new password has been emailed to the account provided.');
                    }
                });
            }

            function doLogin(popup){
                $.cookie("login", "true");
                var ds = popup.opts.ds;
                // clear the errors
                $('#login-popup-error').addClass('hidden');

                // Check if user has cookies enabled
                if (!AL.utils.cookiesEnabled()) {
                    $('#login-popup-error').html(LOGIN_POPUP_COOKIE_ERROR);
                    $('#login-popup-error').removeClass('hidden');
                    return;
                }
                var uname = $('#login-popup-username').val();
                var passw = $.trim($('#login-popup-password').val());
                if (passw !== AL.LOGIN_POPUP_HIDDEN_PASS) {
                    passw = AL.utils.MD5(passw);
                }
                var rememberMe = !!$('#rememberme:checked').length;
                var autoLogin = !!$('#rememberme:checked').length;
                var curpage = window.location.href;
                var sn = $('#login-popup-sn_id').val();
                // ~~N~~ iid parameter added in ajax request by ninad bug #1489
                $.post(AL.LOGIN_POPUP_SUBMIT_URL, {
                    username: uname,
                    passw: passw,
                    autologin: autoLogin,
                    rememberme: rememberMe,
                    iid: ds.iid,
                    curpage: curpage,
                    sn: sn
                },
                function(ajaxdata){
                    var data = $.evalJSON(ajaxdata);

                    // we have an error
                    if(!!data.error){

                        // in the future, should get error message passed in..
                        if(data.error == 1){
                            $('#login-popup-error').html('Check your email to confirm your registration.');
                        } else if(data.error == 2){
                            $('#login-popup-error').html('Oops, your email address or password is invalid.');
                        } else if(data.error == 3){
                            $('#login-popup-error').html('You have previously converted this account to use Facebook Sign In. Please use the Facebook Connect button below.');
                        } else {
                            $('#login-popup-error').html('Unknown error occured.');
                        }

                        $('#login-popup-error').removeClass('hidden');
                        $('.loading_gif_signin').css({
                            'display':'none'
                        });

                    } else {
                        popup.hide();
                        AL.Tracker.track('/ALSignIn.al');

                        if (popup.opts.cancelRedirect !== true){
                            if (!!data.redirect && !!data.redirect != ''){
                                document.location = data.redirect;
                            } else if(!!ds.redirectPage && ds.redirectPage != ''){
                                document.location = ds.redirectPage;
                            } else {
                                document.location = AL.LOGIN_POPUP_DEFAULT_REDIRECT;
                            }
                        } else {
                            popup.opts.onDone();
                        }
                    }
                });
            }

            function toggleSignIn() {
                $("#login-popup-signIn-with-facebook").show();

                $("#signInWithYourEmail").click(function() {
                    $("#login-popup-signIn-with-facebook").hide();
                    $("#login-popup-linked-signIn").show();
                });
            }

            function showSigninContentOnly(){
                $('#login-popup-container-content').removeClass('hidden');
                $('#join-popup-container-content').addClass('hidden');
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
                LoginPopup: function(opts) {
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

                    showSigninContentOnly()
                    var opts = this.opts;
                    proto.show.call(this);


                    // Set focus to correct box
                    if ($("#login-popup-username").attr("value") == ('Email Address' || '')) {
                        setTimeout("$(\"#login-popup-username\").focus();", 100);
                    } else {
                        setTimeout("$(\"#login-popup-password\").focus();", 100);
                    };
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
                renderData: function() {
                    var	opts = this.opts,
                    wrapper = opts.wrapper;
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
                        $("#login-popup-container-wrapper").css("width","300px");

                        $('#login-popup-signin-content').addClass('hidden');
                        $('#login-popup-prompt-container').removeClass('hidden');
                        $('#login-popup-prompt').text(opts.unauthText);
                    }
                    toggleSignIn();
                },

                /**
				 * Reset template to original state.
				 */
                reset: function() {
                    // show proper section
                    $('#login-popup-forgotpassword-content').addClass('hidden');
                    $('#login-popup-forgotpassword-instructions').html(AL.LOGIN_POPUP_FORGOT_DEFAULT_MSG).removeClass('error');
                    $('#login-popup-form-forgotpassword').removeClass('hidden');
                    $('#login-popup-forgotpassword-not-a-member').removeClass('hidden');
                    $('#login-popup-signin-content').removeClass('hidden');
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

                    /*
					//join link header
					$("#loadJoin").unbind('click').click(function(){
						redirect('/home/index/doLogin'); alert('what is it');
						$('#login-popup-signin-content').addClass('hidden');
						$('#login-popup-container-content').addClass('hidden');
						$('#join-popup-container-content').removeClass('hidden');
					});
					*/

                    // Join link from header
                    //$("#loadJoin").unbind('click').click(function(){
                    //		alert('Join Link from Header');
                    //$('#login-popup-container').css('display','block');
                    //$("#login-popup-signIn-with-facebook").hide();
                    //$('#login-popup-signin-content').addClass('hidden');
                    //$('#login-popup-container-content').addClass('hidden');
                    //var signInBoxPosition = $("#login-popup-container").position().left;
                    //$('#login-popup-container').css('left',(signInBoxPosition - 50));
                    //$('#join-popup-container-content').removeClass('hidden');
                    //});


                    // join link
                    $("#join-popup-registration").unbind('click').click(function(){
                        $('#login-popup-signin-content').addClass('hidden');
                        $('#login-popup-container-content').addClass('hidden');
                        var signInBoxPosition = $("#login-popup-container").position().left;
                        $('#login-popup-container').css('left',(signInBoxPosition + 50));
                        $('#join-popup-container-content').removeClass('hidden');
                    });

                    // sign in link
                    /*$("#signInWithYourEmail").unbind('click').click(function(){
						var signInBoxPosition = $("#login-popup-container").position().left;
						$('#login-popup-container').css('left',(signInBoxPosition - 50));
						$('#login-popup-signin-content').removeClass('hidden');
						$('#login-popup-container-content').removeClass('hidden');
						$('#login-popup-forgotpassword-content').addClass('hidden');
						$('#join-popup-container-content').addClass('hidden');
					});
					*/
                    // forgot password link
                    $('#login-popup-forgot-link').unbind('click').click(function(){
                        $('#login-popup-signin-content').addClass('hidden');
                        $('#login-popup-container-content').addClass('hidden');
                        $('#join-popup-container-content').addClass('hidden');
                        $('#login-popup-forgotpassword-content').removeClass('hidden');

                        // forgot password validator - load only if the user has forgotten the pass
                        if(!pop.forgotValidator){
                            pop.forgotValidator = $('#login-popup-form-forgotpassword').validate({
                                rules: {
                                    "email": {
                                        required: true,
                                        email: true
                                    }
                                },
                                submitHandler: function(form){
                                    doForgotPwd();
                                    return false;
                                }
                            });
                        }
                        return false;
                    });
/*
                    // sign in validator
                    if(!pop.signinValidator){
                        pop.signinValidator = $('#login-popup-form-signin').validate({
                            rules: {
                                "username": {
                                    required: true,
                                    email: true
                                },
                                "password": {
                                    required:true
                                }
                            },
                            submitHandler: function(form){
                                $(".loading_gif_signin").css({
                                    "display": "block"
                                });
                                doLogin(pop);
                                return false;
                            }
                        });
                    }

                    // submit signin
                    $('#login-popup-signin-button').unbind('click').click(function(){
                        $('#login-popup-form-signin').submit();
                    });
                    $('#login-popup-form-signin').keypress(function(e) {
                        if (e.which == AL.ENTER_KEY) {
                            $('#login-popup-form-signin').submit();
                        }
                    });
                    // submit forgot password
                    $('#login-popup-forgotpassword-submit').unbind('click').click(function(){
                        $('#login-popup-form-forgotpassword').submit();
                    });

                    $('#login-popup-forgotpassword-email, #login-popup-username').keyup(function(e) {
                        if (e.keyCode === 9 || e.keyCode === 32){
                            var th = $(this);
                            th.val(jsface.trim(th.val()));
                        }
                    });

                    $('#login-popup-forgotpassword-email').keydown(function(e) {
                        if (e.keyCode == AL.ENTER_KEY) {
                            $('#login-popup-form-forgotpassword').submit();
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
                    $('#login-popup-prompt-link', this.opts.wrapper).unbind('click').bind('click', function(){
                        $('#login-popup-signin-content').removeClass('hidden');
                        $('#login-popup-prompt-container').addClass('hidden');
                    });

   */
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