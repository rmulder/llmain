/**
 * Legacy Widgets
 * Widgets broken out from old global.js file
 * These are still being used throughout the site.
 */

/**
 * A countdown display for text boxes.
 * @method characterCounter
 *
 * @param maxCount {integer} number of characters allowed in the area
 * @param textareaID {String} reference to the DOM element to be character counted
 * @param counterDisplayID {String} counter to be updated
 * @param defaultMsg {String} default message for area to be counted (to prompt use)
 * @param _errMsg {Boolean} display an error state if user clips max count
 *
 * @param _counterDisplay {string} id for the counter display DOM element.
 * @param _counterDOM {object} DOM element reference for the counter display area.
 * @param _defaultMsg {string} default message for text area to be cleared on focus.
 * @param _maxCount {integer} maximum number of characters allowed in the textarea.
 * @param _errMsg {string} id for the message display DOM element.
 * @param _msgBoxDOM {string} DOM element reference for the message display area.
 * @param _textarea {string} id for the textarea DOM element.
 * @param _textareaDOM {string} DOM element reference for the textarea.
 * @param _errBoxId {string} new id for error message insertion. Based on textareaID.
 */
AL.widgets.characterCounter = function(maxCount, textareaID, counterDisplayID, defaultMsg, errMsg) {
	var _counterDisplay = "#" + counterDisplayID,
		_counterDOM = $(_counterDisplay),
		_defaultMsg = $.trim(defaultMsg) || false,
		_maxCount = maxCount || 200,
		_errMsg = errMsg || false,
		_msgBoxDOM = null,
		_textarea = "#" + textareaID,
		_textareaDOM = $(_textarea),
		_errBoxId = textareaID + "_warning";

	/**
     * Change display message if there is a message box present
     * @private
     * @method _changeDisplayMessage
	 */
	function _changeDisplayMessage(msg) {
		if (_errMsg){
			if (!_msgBoxDOM){
				_textareaDOM.after('<div id="' + _errBoxId + '" class="error">' + msg + '</div>');
				_msgBoxDOM = $("#" + _errBoxId);
			}
			_msgBoxDOM.html(msg).show('fast');
		}
	}

	/**
     * Set the maximum character count for the text area.
     * @private
     * @method _characterCount
	 */
	function _characterCount(e) {
		// prevent bubbling
		e.stopPropagation();

		if (_textareaDOM.val().length > _maxCount) {
			_textareaDOM.val(_textareaDOM.val().substring(0, _maxCount));
			_updateCounter(0);
			_changeDisplayMessage("You cannot exceed the " + _maxCount + " character maximum.");
		} else {
			if ($("#" + _errBoxId).length && _textareaDOM.val().length <= (_maxCount - 1)) {
				_msgBoxDOM.hide('fast').css("display","none");
			}
			_updateCounter(_maxCount - _textareaDOM.val().length);
		}
	}

	/**
     * a small local function that clears the textarea
     * @private
     * @method _clearMessage
	 */
	function _clearMessage(e) {
		// prevent bubbling
		e.stopPropagation();

			var textareaVal = $.trim(_textareaDOM.val());
				AL.Logger.info("textareaVal is: " + textareaVal);
				AL.Logger.info("defaultMsg is: " + _defaultMsg);
		// Make sure they haven't already started typing before you clear it.
		if (_defaultMsg && textareaVal === _defaultMsg){
			_textareaDOM.val("");
			  _updateCounter(_maxCount);
		}

	}

	function _updateCounter(new_count) {
		if (_counterDOM.length) {
			_counterDOM.html(new_count);
		}
	}

	// Do the DOM attachments
		_textareaDOM.focus(function(e){
			_clearMessage(e);
		}).keyup(function(e){
			_characterCount(e);
		}).keydown(function(e){
			_characterCount(e);
		});
}; // End characterCounter

/**
 * A toggle for any faq content. It uses the following classes:
 * 		.more - the click to toggle to expand or contract text
 *		.moreAnswer - the class on the large answer (set to display:none in css)
 * 		.shortAnswer - the truncated text
 */
AL.widgets.faqToggle = function(){
	$('.more').bind('click', function (){
		AL.Logger.info('AL.widgets.faqToggle fired.');
		$(this).parent().find('.moreAnswer').toggle();
		$(this).parent().find('.shortAnswer').toggle();

		if ($(this).parent().find('.moreAnswer').is(':visible')) {
			$(this).html('less');
		}
		else {
			$(this).html('more');
		}
	});
}; // End faqToggle

/**
 * create a simple youtube modal
 * for media files page
 */
AL.widgets.SimpleYoutubeModal = (function(){

	$('.modal_close, #preview_overlay').live('mousedown',function(){
		$('#preview_content').html('');
		$('#preview_promo').fadeOut();
	});

	$(document).keyup(function(e) {
		if (e.keyCode == 27) { // ESC key
			$('#preview_content').html('');
			$('#preview_promo').fadeOut();
		}
	});

	return function(handle){
		$(handle).click(function(e){
			e.preventDefault();

			var maskHeight = $(document).height();
			var maskWidth = $(window).width();
			var id = '#preview_inner';
			var video_id = $(handle).attr('rel');

			$('#preview_promo').css({
				'width': maskWidth,
				'height': maskHeight
			}).fadeIn();
			$('#preview_overlay').fadeIn();
			$('#preview_content').html('<object width="560" height="340"><param name="movie" value="http://www.youtube.com/v/' + video_id + '&hl=en_US&fs=1&autoplay=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/' + video_id + '&hl=en_US&fs=1&autoplay=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="560" height="340"></embed></object>');

			var winH = $(window).height();
			var winW = $(window).width();

			//Set the popup window to center
			$(id).css({
				width: 560,
				height: 376,
				top: winH/2 - 170,
				left: winW/2 - 280
			});
		});
	};
})();


AL.widgets.FBSignIn = function(ev) {
	$.cookie("login", "true");
	AL.tools.Facebook.connect();
}

AL.widgets.UnauthBanner = function() {
	AL.tools.Facebook.init(false);
	$("#banner_facebook_signin, .listing_facebook_signin, #banner .banner_facebook_signin").click(AL.widgets.FBSignIn);
	
	// Sign In Link at the bottom of the page (bug #6384)
	$('#activity_list_signin.banner_facebook_signin').live('click', function(){
		window.scroll(0, 0);
		$('#header_login').trigger('click');
	});
};