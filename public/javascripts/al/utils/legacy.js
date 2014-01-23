/**
 * Legacy Utilities
 * Utilities broken out from old global.js file
 * These are still being used throughout the site.
 */

/**
 * Convert string into an html-safe id
 */
AL.utils.safeId = function(id) {
	if (typeof id !== 'string') {
		return '';
	}
	return $.trim(id.toLowerCase()).replace(/[^A-Za-z0-9]+/g, '-');
};


/**
 * Prevent multiple submits
 * 
 * AL.utils.submitOnce must be called after all other events have been bound
 * to the form
 * 
 * @param {Object} form to mediate
 * @param {Object} options 
 * @return {Object} contains reset and block methods bound to given form
 */
AL.utils.submitOnce = function(form, options) {
	/**
	 * Instantiate new object on each call
	 */
	return (function(){
		var form_elt = $(form);
		var prevent_submit = false;
		var opts = $.extend({
			auto: false
		}, options);
		
		if (!form_elt.length || form_elt.length > 1) {
			AL.Logger.warn('AL.utils.sumbitOnce: bad element', form);
			if (form_elt.length > 1) {
				AL.Logger.warn('AL.utils.sumbitOnce: please select unique element');
			}
			return {reset:$.noop, block:$.noop};
		}
		
		// bind the submit preventor!
		form_elt.unbind('submit.submitOnce').bind('submit.submitOnce', function(e){
			AL.Logger.info('AL.utils.sumbitOnce: prevent_submit', prevent_submit);
			if (opts.auto && !prevent_submit) {
				AL.Logger.info('AL.utils.sumbitOnce: Auto blocking active');
				// allow first submit (until reset)
				prevent_submit = true;
				form_elt.addClass('submitting');
				
				// return nothing
				return undefined;
			}
			
			if (prevent_submit) {
				// prevent other bound events from running
				AL.Logger.info('AL.utils.sumbitOnce: Attempting to stop Immediate Propogation');
				e.stopImmediatePropagation();
				e.preventDefault();

				// prevent form submission (for older browsers)
				return false;
			}
		});
		
		/**
		 * Return reset function
		 */
		return {
			reset: function() {
				form_elt.removeClass('submitting');
				prevent_submit = false;
			},
			block: function() {
				prevent_submit = true;
				form_elt.addClass('submitting');
			}
		};
	})();
};


/**
 * Submit an html button on enter on focus
 */
AL.utils.enterSubmit = function(buttons) {
	buttons.unbind('focus.EnterSubmit').unbind('blur.EnterSubmit').bind({
		'focus.EnterSubmit': function() {
			var that = $(this);
			that.unbind('keydown.EnterSubmit').bind('keydown.EnterSubmit', function(e) {
				if (e.keyCode == AL.ENTER_KEY) {
					that.trigger('click');
				}
			});
		},
		'blur.EnterSubmit': function() {
			$(this).unbind('keydown.EnterSubmit');
		}
	});
};

/**
 * Test for ability to set cookies
 * @return {Boolean} true if we can set cookies
 */
AL.utils.cookiesEnabled = function() {
	$.cookie('cookiesEnabled', '1', {path: '/'});
	if ($.cookie('cookiesEnabled') === '1') {
		// be nice and remove the cookie
		$.cookie('cookiesEnabled', '', {path: '/', expires: -1});
		return true;
	} else {
		return false;
	}
};

/**
 * Check if an element exists in an array
 * @param array {Array} the array to search
 * @param element {Mixed} the element find in array
 * @param trim {Boolean} flag to trim the element before comparison - only valid for arrays of strings
 */
AL.utils.inArray = function(array, element, trim) {
	var trimFn = trim ? $.trim : function(str){ return str; },
		x;
	
	for (x = 0; x < array.length; x++) {
		if (trimFn(array[x]) === trimFn(element)) {
			return x;
		}
	};
	return -1;
};

/**
 * Remove default text in input field or textarea on select
 * @param elts {jQueryElts} used to select the input element(s) with jquery
 * @param opts {Object} 
 *         - replaceOnFocus {Boolean} replace text on focus if it matches placeholder
 *           text. default is true.
 *         - selectOnFocus {String|Boolean} false disables this feature, otherwise
 *           'all' always replaces text, 'placeholder' only selects the placeholder
 *           text. (default is all)
 *         - toggleClass {String} added to the element when the placeholder text is 
 *           shown the default is set to 'placeholder'. If no class is desired,
 *           pass in false
 */
AL.utils.usePlaceholder = (function(){
	// nativePlaceholder is a boolean that will eventually be used to detect support
	// of the HTML5 placeholder attribute; with it we can let the placeholder shine 
	// through instead of clobbering it with javascript. for the time being that 
	// functionality is not yet built out!
	
	//var nativePlaceholder = typeof document.createElement('input').placeholder !== 'undefined';
	
	return function(elts, opts) {
		if (!elts) {
			AL.Logger.warn('AL.utils.usePlaceholder: missing param (elts)');
			return;
		}
		
		// make sure we have jquery included in the element
		elts = $(elts);
		opts = $.extend({
			toggleClass: 'placeholder',
			selectOnFocus: 'all',
			replaceOnFocus: true,
			initWithPlaceholder: false
		}, opts);
		
		// if no placeholder, set the current text to be the placeholder
		$(elts).each(function setPlaceholder(i, elt){
			elt = $(elt);
			if (!elt.attr('placeholder')) {
				elt.attr('placeholder', elt.val());
			}
		
			//
			if (opts.initWithPlaceholder && !elt.val()) {
				elt.val(elt.attr('placeholder'));
			}
		
			// add the toggle class if the default value is present
			if (opts.toggleClass && elt.attr('placeholder') === elt.val()) {
				elt.addClass(opts.toggleClass);
			}
		});
	
		var removeDefaultText = function(e) {
			var elt = $(this);
			var ret = true;		
			if (elt.val() === elt.attr('placeholder')) {
				if (opts.replaceOnFocus) {
					elt.val('');
				}
				if (opts.toggleClass) {
					elt.removeClass(opts.toggleClass);
				}
				if (opts.selectOnFocus === 'placeholder') {
					elt.select();
					ret = false;
				}
			}
			if (opts.selectOnFocus === 'all') {
				elt.select();
				ret = false;
			}
			elt.unbind('click.userPlaceholder');
			return ret;
		};
	
		// bind focus and blur events
		elts.unbind('click.usePlaceholder').unbind('blur.usePlaceholder').bind({
			'click.usePlaceholder': removeDefaultText,
			'blur.usePlaceholder': function removeDefaultTextBlur() {
				var elt = $(this);
				if ($.trim(elt.val()) === '') {
					elt.val(elt.attr('placeholder'));
					if (opts.toggleClass) {
						elt.addClass(opts.toggleClass);
					}
				}
				elt.bind('click.usePlaceholder', removeDefaultText);
			}
		});
	};
})();

/**
 * Boolean function verifies if the city state combination 
 * passed in is valid. Currently this does not keep track of
 * where the request came from, but tracks that a search is being
 * performed.
 * @param value 'city, state' string
 * @param source should contain the page this function is called from
 * @return boolean true if the value passed in is valid
 */
AL.utils.verifyCityState = function(value, source) {
	var exists = false;
	$.ajax({
		type: "POST",
		url: "/ajax/check_city",
		async: false,
		data: "city=" + value + "&state=",
		success: function(data) {
			if (data == 1) {
				if (AL.Profile.login) {
					try {
						AL.Tracker.track('/AuthSearchDone.al');
					} catch(e) {};
				}
				else {
					try{
						AL.Tracker.track('/UnAuthSearchDone.al');
					} catch(e) {};
				}
				exists = true;
			}
	}});
	return exists;
};

/**
 * Replace disallowed characters in the seach terms
 * @params search term string
 * @return search term string stripped of disallowed charaters
 */
AL.utils.formatSearchTerm = function (term) {
	//term = (term.replace(", ","-").replace(",","-").replace(" & ","-")).replace(" ","-");
	if (term) {
		return $.trim(term.replace(/[^A-Za-z0-9~%\.\:_\-,@\+\?=&\s]+/g, '')).replace(/\s+/g, '-');
	} else {
		return '';
	}
};

/**
 * format a string to an acceptable css id
 * @param {String} id the unescaped desired css id or class
 * @return {String} the formatted id or calss for css use
 */
AL.utils.formatCSSid = function (id) {
	if (typeof id === 'string') {
		return $.trim(id).replace(/[^A-Za-z0-9\_]+/g, '-').toLowerCase();
	} else {
		return '';
	}
};
	
/**
 * Capitalise first letter of city and state code
 * @params location 
 * @return formatted location for display
 */
AL.utils.formatLocationDisplay = function(location) {
	location = location.replace(/^\s+|\s+$/g, '').replace(", ",",");
	var loc = location.split(",");
	var city = AL.utils.firstLetterCaps(loc[0]);
	var state = loc[1].toUpperCase();		
	return city+", "+state;
};
	
/**
 * Capitalise first letter of all words in a string
 * @params string 
 * @return caps_string
 */
AL.utils.firstLetterCaps = function (string){
	// check for errors...
	if (typeof string !== 'string') {
		return null;
	}
	var string_arr = string.split(" ");
	var caps_string = "";
	var word;
	for( var i in string_arr ) {
		word = string_arr[i];
		if(word != "") {
			word_caps = (word.substring(0,1).toUpperCase()) + (word.substring(1,word.length));
			if(i !== 0) {
				caps_string += " ";
			}
			caps_string += word_caps;
		}
	} 
	return caps_string.replace(/^\s+|\s+$/g, '');
};

/**
 * Click tacker
 * need this to be accessible outside of the ClickTracker app, 
 * so it can be used by individual widgets as needed
 * @param {string} bid Business ID of the item being tracked
 * @param {string} type the type of click to track ['website', 'offer', 'business']
 * @param {Function} [callback] returns 'true' on success, 'false' on failure
 */
AL.utils.trackClick = function (bid, type, callback){
	if (typeof callback !== 'function') {
		callback = jsface.emptyFn;
	}
	
	if (!bid) {
		AL.Logger.warn('AL.utils.trackClick: no bid passed in');
		callback(false);
		return;
	}	
	var logEvent = [{id: bid, type: 0}];
	
	switch (type) {
		case 'website':
			logEvent[0].type = AL.EVENT_LOG_WEBSITE_CLICKTHRU;
		break;
		case 'offer':
			logEvent[0].type = AL.EVENT_LOG_OFFER_CLICKTHRU;
		break;
		case 'business':
			logEvent[0].type = AL.EVENT_LOG_BUSINESS_CLICKTHU;
		break;
		default:
			AL.Logger.warn('AL.utils.trackClick: unknown type ' + type);
			callback(false);
			return;
	}
	AL.utils.logEvents(logEvent, callback);
};


/**
 * Event logger
 * log one or more events 
 * @param {Object[]} events:
 *        {int} id ID of the item being tracked
 *        {int} type the type of click to track
 * @param {Function} [callback] returns 'true' on success, 'false' on failure
 */
AL.utils.logEvents = function (events, callback) {
	var url = "/ajax/log_event/";
	var type_id = '';
	if (typeof callback !== 'function') {
		callback = jsface.emptyFn;
	}
	
	if (!events) {
		AL.Logger.warn('AL.utils.logEvents: no events passed in');
		callback(false);
		return;
	}
	
	// if array post a JSON encoded string to backend
	if (events.length > 1) {
		var jsonEvents = $.toJSON(events);
		$.post('/ajax/log_events', {
			url: window.location.href,
			events: jsonEvents
		}, function() {
			callback(true);
		});
	} else if (events.length === 1) {
		var id = events[0].id;
		var type = events[0].type;
		if (!events[0].url) {
			events[0].url = window.location.href;
		}
		if (!id || !type) {
			AL.Logger.warn('AL.utils.logEvents: events not properly formatted', events);
			callback(false);
			return;
		}
		$.post('/ajax/log_event/' + id + '/' + type, events[0], function() {
			callback(true);
		});
	} else {
		AL.Logger.warn('AL.utils.logEvents: no events present');
		callback(false);
		return;
	}
	
	AL.Logger.info('AL.utils.logEvents logs', events);
};

/**
 * MD5 generator
 */
AL.utils.MD5 = function (string) {
	function RotateLeft(lValue, iShiftBits) {
		return (lValue<<iShiftBits) | (lValue>>>(32-iShiftBits));
	}

	function AddUnsigned(lX,lY) {
		var lX4,lY4,lX8,lY8,lResult;
		lX8 = (lX & 0x80000000);
		lY8 = (lY & 0x80000000);
		lX4 = (lX & 0x40000000);
		lY4 = (lY & 0x40000000);
		lResult = (lX & 0x3FFFFFFF)+(lY & 0x3FFFFFFF);
		if (lX4 & lY4) {
			return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
		}
		if (lX4 | lY4) {
			if (lResult & 0x40000000) {
				return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
			} else {
				return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
			}
		} else {
			return (lResult ^ lX8 ^ lY8);
		}
	}

	function F(x,y,z) { return (x & y) | ((~x) & z); }
	function G(x,y,z) { return (x & z) | (y & (~z)); }
	function H(x,y,z) { return (x ^ y ^ z); }
	function I(x,y,z) { return (y ^ (x | (~z))); }

	function FF(a,b,c,d,x,s,ac) {
		a = AddUnsigned(a, AddUnsigned(AddUnsigned(F(b, c, d), x), ac));
		return AddUnsigned(RotateLeft(a, s), b);
	};

	function GG(a,b,c,d,x,s,ac) {
		a = AddUnsigned(a, AddUnsigned(AddUnsigned(G(b, c, d), x), ac));
		return AddUnsigned(RotateLeft(a, s), b);
	};

	function HH(a,b,c,d,x,s,ac) {
		a = AddUnsigned(a, AddUnsigned(AddUnsigned(H(b, c, d), x), ac));
		return AddUnsigned(RotateLeft(a, s), b);
	};

	function II(a,b,c,d,x,s,ac) {
		a = AddUnsigned(a, AddUnsigned(AddUnsigned(I(b, c, d), x), ac));
		return AddUnsigned(RotateLeft(a, s), b);
	};

	function ConvertToWordArray(string) {
		var lWordCount;
		var lMessageLength = string.length;
		var lNumberOfWords_temp1=lMessageLength + 8;
		var lNumberOfWords_temp2=(lNumberOfWords_temp1-(lNumberOfWords_temp1 % 64))/64;
		var lNumberOfWords = (lNumberOfWords_temp2+1)*16;
		var lWordArray=Array(lNumberOfWords-1);
		var lBytePosition = 0;
		var lByteCount = 0;
		while ( lByteCount < lMessageLength ) {
			lWordCount = (lByteCount-(lByteCount % 4))/4;
			lBytePosition = (lByteCount % 4)*8;
			lWordArray[lWordCount] = (lWordArray[lWordCount] | (string.charCodeAt(lByteCount)<<lBytePosition));
			lByteCount++;
		}
		lWordCount = (lByteCount-(lByteCount % 4))/4;
		lBytePosition = (lByteCount % 4)*8;
		lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80<<lBytePosition);
		lWordArray[lNumberOfWords-2] = lMessageLength<<3;
		lWordArray[lNumberOfWords-1] = lMessageLength>>>29;
		return lWordArray;
	};

	function WordToHex(lValue) {
		var WordToHexValue="",WordToHexValue_temp="",lByte,lCount;
		for (lCount = 0;lCount<=3;lCount++) {
			lByte = (lValue>>>(lCount*8)) & 255;
			WordToHexValue_temp = "0" + lByte.toString(16);
			WordToHexValue = WordToHexValue + WordToHexValue_temp.substr(WordToHexValue_temp.length-2,2);
		}
		return WordToHexValue;
	};

	function Utf8Encode(string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";

		for (var n = 0; n < string.length; n++) {

			var c = string.charCodeAt(n);

			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}

		}

		return utftext;
	};

	var x=Array();
	var k,AA,BB,CC,DD,a,b,c,d;
	var S11=7, S12=12, S13=17, S14=22;
	var S21=5, S22=9 , S23=14, S24=20;
	var S31=4, S32=11, S33=16, S34=23;
	var S41=6, S42=10, S43=15, S44=21;

	string = Utf8Encode(string);

	x = ConvertToWordArray(string);

	a = 0x67452301; b = 0xEFCDAB89; c = 0x98BADCFE; d = 0x10325476;

	for (k=0;k<x.length;k+=16) {
		AA=a; BB=b; CC=c; DD=d;
		a=FF(a,b,c,d,x[k+0], S11,0xD76AA478);
		d=FF(d,a,b,c,x[k+1], S12,0xE8C7B756);
		c=FF(c,d,a,b,x[k+2], S13,0x242070DB);
		b=FF(b,c,d,a,x[k+3], S14,0xC1BDCEEE);
		a=FF(a,b,c,d,x[k+4], S11,0xF57C0FAF);
		d=FF(d,a,b,c,x[k+5], S12,0x4787C62A);
		c=FF(c,d,a,b,x[k+6], S13,0xA8304613);
		b=FF(b,c,d,a,x[k+7], S14,0xFD469501);
		a=FF(a,b,c,d,x[k+8], S11,0x698098D8);
		d=FF(d,a,b,c,x[k+9], S12,0x8B44F7AF);
		c=FF(c,d,a,b,x[k+10],S13,0xFFFF5BB1);
		b=FF(b,c,d,a,x[k+11],S14,0x895CD7BE);
		a=FF(a,b,c,d,x[k+12],S11,0x6B901122);
		d=FF(d,a,b,c,x[k+13],S12,0xFD987193);
		c=FF(c,d,a,b,x[k+14],S13,0xA679438E);
		b=FF(b,c,d,a,x[k+15],S14,0x49B40821);
		a=GG(a,b,c,d,x[k+1], S21,0xF61E2562);
		d=GG(d,a,b,c,x[k+6], S22,0xC040B340);
		c=GG(c,d,a,b,x[k+11],S23,0x265E5A51);
		b=GG(b,c,d,a,x[k+0], S24,0xE9B6C7AA);
		a=GG(a,b,c,d,x[k+5], S21,0xD62F105D);
		d=GG(d,a,b,c,x[k+10],S22,0x2441453);
		c=GG(c,d,a,b,x[k+15],S23,0xD8A1E681);
		b=GG(b,c,d,a,x[k+4], S24,0xE7D3FBC8);
		a=GG(a,b,c,d,x[k+9], S21,0x21E1CDE6);
		d=GG(d,a,b,c,x[k+14],S22,0xC33707D6);
		c=GG(c,d,a,b,x[k+3], S23,0xF4D50D87);
		b=GG(b,c,d,a,x[k+8], S24,0x455A14ED);
		a=GG(a,b,c,d,x[k+13],S21,0xA9E3E905);
		d=GG(d,a,b,c,x[k+2], S22,0xFCEFA3F8);
		c=GG(c,d,a,b,x[k+7], S23,0x676F02D9);
		b=GG(b,c,d,a,x[k+12],S24,0x8D2A4C8A);
		a=HH(a,b,c,d,x[k+5], S31,0xFFFA3942);
		d=HH(d,a,b,c,x[k+8], S32,0x8771F681);
		c=HH(c,d,a,b,x[k+11],S33,0x6D9D6122);
		b=HH(b,c,d,a,x[k+14],S34,0xFDE5380C);
		a=HH(a,b,c,d,x[k+1], S31,0xA4BEEA44);
		d=HH(d,a,b,c,x[k+4], S32,0x4BDECFA9);
		c=HH(c,d,a,b,x[k+7], S33,0xF6BB4B60);
		b=HH(b,c,d,a,x[k+10],S34,0xBEBFBC70);
		a=HH(a,b,c,d,x[k+13],S31,0x289B7EC6);
		d=HH(d,a,b,c,x[k+0], S32,0xEAA127FA);
		c=HH(c,d,a,b,x[k+3], S33,0xD4EF3085);
		b=HH(b,c,d,a,x[k+6], S34,0x4881D05);
		a=HH(a,b,c,d,x[k+9], S31,0xD9D4D039);
		d=HH(d,a,b,c,x[k+12],S32,0xE6DB99E5);
		c=HH(c,d,a,b,x[k+15],S33,0x1FA27CF8);
		b=HH(b,c,d,a,x[k+2], S34,0xC4AC5665);
		a=II(a,b,c,d,x[k+0], S41,0xF4292244);
		d=II(d,a,b,c,x[k+7], S42,0x432AFF97);
		c=II(c,d,a,b,x[k+14],S43,0xAB9423A7);
		b=II(b,c,d,a,x[k+5], S44,0xFC93A039);
		a=II(a,b,c,d,x[k+12],S41,0x655B59C3);
		d=II(d,a,b,c,x[k+3], S42,0x8F0CCC92);
		c=II(c,d,a,b,x[k+10],S43,0xFFEFF47D);
		b=II(b,c,d,a,x[k+1], S44,0x85845DD1);
		a=II(a,b,c,d,x[k+8], S41,0x6FA87E4F);
		d=II(d,a,b,c,x[k+15],S42,0xFE2CE6E0);
		c=II(c,d,a,b,x[k+6], S43,0xA3014314);
		b=II(b,c,d,a,x[k+13],S44,0x4E0811A1);
		a=II(a,b,c,d,x[k+4], S41,0xF7537E82);
		d=II(d,a,b,c,x[k+11],S42,0xBD3AF235);
		c=II(c,d,a,b,x[k+2], S43,0x2AD7D2BB);
		b=II(b,c,d,a,x[k+9], S44,0xEB86D391);
		a=AddUnsigned(a,AA);
		b=AddUnsigned(b,BB);
		c=AddUnsigned(c,CC);
		d=AddUnsigned(d,DD);
	}

	var temp = WordToHex(a)+WordToHex(b)+WordToHex(c)+WordToHex(d);

	return temp.toLowerCase();
};