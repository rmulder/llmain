/**
 * Validator extensions
 */

// ~~N~~ Added By Ninad #2204 
jQuery.validator.addMethod( 
  "alphaReg", 
  function(value, element) { 
  	//alert(/[^a-z]/.test(value));
	var regex = /[^a-zA-Z\ \-\_]/;
	return regex.test(value)?false:true;
  }, 
  "Please enter valid name." 
); 
// ~~N~~ ENDS 
jQuery.validator.addMethod(
	"validPassword",
	function(value, element, regexp) {
		if(regexp.constructor != RegExp) {
			regexp = new RegExp('^([^ ]{6,12})$');
		}
		else if(regexp.global) {
			regexp.lastIndex = 0;
		}
		return regexp.test(value);
	},
	"No spaces are allowed in password."
);
jQuery.validator.addMethod(
  "checkZip",
  function( value, element ) {
	  if( value.length == 5 ) return true;
	  else return false;
  }
);

// ~~N~~ Added By Ninad #2958 
jQuery.validator.addMethod( 
  "checkValidCity", 
  function(value, element) {
  	var ret; 
	$.ajax({
		type: "POST",
		url: "/ajax/check_city",
		data: "city="+value,
		async: false,
		success: function(data){
			if(parseInt(data) == 1) ret =  true;
			else ret = false;
		}
	});
	return ret;
  }, 
  "Please enter valid city." 
);
jQuery.validator.addMethod(
	'checkCityState', function(value, element) {
		var cityStateVal = $.trim($(element).val());
		var cityStateSplit = [];
		cityStateSplit = cityStateVal.split(',');
		if(cityStateSplit[1] && cityStateSplit[1] !== '' && cityStateSplit[1].match(/[A-z]/g) && cityStateSplit[1].length >= 3){
			return true;
		} else {
			return false;
		}
	}, "Please enter valid City, State."
);

/**
 * Check that a value does not equal a placeholder (only useful in SPECIFIC cases, when the placeholder is not a valid value)
 */
jQuery.validator.addMethod("notPlaceholder", function(value, element) { 
  return $(element).val() != $(element).attr('placeholder'); 
}, "Please enter a value");