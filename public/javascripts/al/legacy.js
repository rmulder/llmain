/**
 * The "Kent Dorfman" legacy function area
 * and the sooner it goes, the better...
 */

/** @function */
function checkCommonEmail(emailAddress)
{
	 var reg = /^([A-Za-z0-9_\-\.])+([A-Za-z0-9])+\@([A-Za-z0-9])+([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	 if(reg.test($.trim(emailAddress)))
		return true;
	 else
		return false;
}


// this will be the first to go when i have time - eug
/** @function */
function initxmlhttp()
{
	var xmlhttp ;
	/*@cc_on @*/
	/*@if (@_jscript_version >= 5)
	try {
	xmlhttp=new ActiveXObject("Msxml2.XMLHTTP")
	} catch (e) {
	try {
	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
	} catch (E) {
	xmlhttp=false
	}
	}
	@else
	xmlhttp=false
	@end @*/
	if ( !xmlhttp && typeof XMLHttpRequest!='undefined' )
	{
		try
		{
			xmlhttp = new XMLHttpRequest() ;
		}
		catch (e)
		{
			xmlhttp = false ;
		}
	}
	return xmlhttp ;
}

/** @function */
function check(fb_frm){
	$(".loading_gif_gofavo").css({'display':'inline-block'});

	var frm;

	if(fb_frm) {
		frm = fb_frm;
	} else {
		frm = document.gofavosearch;
	}
	var searchFor = frm.searchfor.value;
	searchFor = $.trim(searchFor);
	frm.searchfor.value = searchFor;
	if(searchFor == "liked businesses")
	{
		alert("Please enter a business name or category");
		$(".loading_gif_gofavo").css({"display" : "none"});
		return false;
	}
	searchFor = searchFor.replace(/\s+$/g,'');
	if(searchFor == "")
	{
		alert("Please enter a business name or category");
		$(".loading_gif_gofavo").css({"display" : "none"});
		return false;
	}
	if(searchFor != "")
	{
		//check desh for first occurance, desh can be in search string but not first
		var chars = "&&";

		if (chars.indexOf(searchFor.charAt(0)) != -1)
		{
			alert ("Special characters are not allowed. Please remove them and try again.");
			$(".loading_gif_gofavo").css({"display" : "none"});
			return false;
		}

		chars = "-";

		if (chars.indexOf(searchFor.charAt(0)) != -1)
		{
			alert ("Special characters are not allowed. Please remove them and try again.");
			$(".loading_gif_gofavo").css({"display" : "none"});
			return false;
		}

		var iChars = '!@#$%^*"()+=[]\\;/{}|:<>?';
		for (var i = 0; i < searchFor.length; i++)
		{
			if (iChars.indexOf(searchFor.charAt(i)) != -1)
			{
				alert ("Special characters are not allowed. Please remove them and try again.");
				$(".loading_gif_gofavo").css({"display" : "none"});
				return false;
			}
		}
	}

	if(frm.where.value=="City, State")
	{
		alert("Please enter or select a city and state abbreviation separated by a comma. e.g. Chicago, IL. Thanks!");
		$(".loading_gif_gofavo").css({"display" : "none"});
		return false;
	}
	frm.where.value=frm.where.value.replace(/\s+$/g,'');
	if(frm.where.value=="")
	{
		alert("Please enter or select a city and state abbreviation separated by a comma. e.g. Chicago, IL. Thanks!");
		$(".loading_gif_gofavo").css({"display" : "none"});
		return false;
	}
	/* ######## # bug 1501 - Changed By Ninad ####### */
	$.ajax({
		type: "POST",url: "/ajax/check_city", async: true, data:"city="+frm.where.value+"&state=",
		success: function(data){
			removed = true;
			if (data == 1) {
				if($('#headerSearchUserId').val() != '') {
					try{AL.Tracker.track('/AuthSearchDone.al');} catch(e) {};
				}
				else {
					try{AL.Tracker.track('/UnAuthSearchDone.al');} catch(e) {};
				}
				frm.submit();
				return true;
			}
			else {
				$(".loading_gif_gofavo").css({"display" : "none"});
				$('#where').focus().select();
				alert("Please enter or select a city and state abbreviation separated by a comma. e.g. Chicago, IL. Thanks!");
				return false;
			}
		}
	});

/*	$.get("/checkForCity.php", { city: frm.where.value, state: '' },
		function(data){
	});
*/

	return false;
}