/**
 * Original Code was by: AjaxRay ( http://www.ajaxray.com/blog/2007/11/09/interactive-character-limit-for-textarea-using-jquery/ )
 * Plugin Written by : Mohammad Amzad Hossain ( tohin.wordpress.com)
 * Thanks to : http://www.learningjquery.com/2007/10/a-plugin-development-pattern
 * 
 * Use to limit the number of characters entered into a form field
 * 
 * Implemented: Luis DeGuzman
 * 
 */

(function($) {

	$.fn.StartCounting = function(options){

		var defaults = {
			limit: 255
		};

		options = $.extend( defaults, options);

		return $(this).each( function(i) {

			var elem = $(this);
			elem.after('');
			elem.keyup( function(i) {
				var limit = options.limit;
				var text = elem.val();
				var textlength = text.length;

				if( textlength > limit) {
					elem.next('.counting_class').val( limit + ' / ' + limit);
					elem.val(text.substr(0,limit));
					return false;
				} else {
					elem.next('.counting_class').val( textlength + ' / ' + limit);
					return true;
				}
			});
			elem.trigger('keyup');
		});
	};

})(jQuery);