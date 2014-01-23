// Credit: http://atwebresults.com
function ajaxUpload(form, url_action, onComplete) {
	function $m(theVar) {
		return document.getElementById(theVar)
	}

	function remove(theVar) {
		try {
			var theParent = theVar.parentNode;
			theParent.removeChild(theVar);
		} catch (error){}
	}

	function addEvent(obj, evType, fn) {
		if (obj.addEventListener)
			obj.addEventListener(evType, fn, true)
		if (obj.attachEvent)
			obj.attachEvent("on" + evType, fn)
	}

	function removeEvent(obj, type, fn) {
		if (obj.detachEvent) {
			obj.detachEvent('on' + type, fn);
		} else {
			obj.removeEventListener(type, fn, false);
		}
	}

	var id = "dcda253e164f55edcee724d3f72801c8";
	remove($m(id))

	form = typeof (form) == "string" ? $m(form) : form;

	var iframe = document.createElement("iframe");
	iframe.setAttribute("id", id);
	iframe.setAttribute("name", id);
	iframe.setAttribute("width", "0");
	iframe.setAttribute("height", "0");
	iframe.setAttribute("border", "0");
	iframe.setAttribute("style", "width: 0; height: 0; border: none;");
	form.parentNode.appendChild(iframe);
	window.frames[id].name = id;
	window.fileUploadCallback = onComplete;

	var doUpload = function() {
		removeEvent($m(id), "load", doUpload);
		var cross = "javascript:trimFirebug=function(s){return s.substring(0, s.lastIndexOf('}') + 1);};try{window.parent.fileUploadCallback(trimFirebug(document.body.innerHTML));}catch(e){} window.parent.fileUploadCallback = undefined; void(0);";
		$m(id).src = cross;
	}

	addEvent($m(id), "load", doUpload);
	form.setAttribute("target", id);
	form.setAttribute("action", url_action);
	form.setAttribute("method", "post");
	form.setAttribute("enctype", "multipart/form-data");
	form.setAttribute("encoding", "multipart/form-data");
	form.submit();
}