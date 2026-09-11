function LabelTextService(){
    var xmlHttp = null;
    if (window.XMLHttpRequest) {
        // IE7+, Firefox, Seamonkey, Opera, Safari, Chrome
        xmlHttp=new XMLHttpRequest();
    } else {
        // old Internet Explorer
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

    if(xmlHttp != null){
    	xmlHttp.onreadystatechange = function() {
    		if (xmlHttp.readyState == 4) {
    			if (xmlHttp.status == 200) {
    				window.jsonObject = eval("(" + xmlHttp.responseText + ")");
					for (window.position in window.jsonObject) {
						if(isNaN(window.position)){
							window.inputEl = document.getElementById(window.position);
							if(window.inputEl != null && window.inputEl != undefined){
								//buttons
								if(window.inputEl.type == "button" || window.inputEl.type == "submit" || window.inputEl.type == "reset"){
									window.inputEl.innerHTML = window.jsonObject[window.position];
								}
								//links and labels
								if(window.inputEl.id.substring(0, 3) == "lbl" || window.inputEl.id.substring(0, 3) == "lnk"){
									window.inputEl.innerHTML = window.jsonObject[window.position];
								}
							}
						}else{
							window.errors[window.position] = window.jsonObject[window.position];
						}
					}
    			} else {
    				alert("AJAX failure! Status: " + xmlHttp.status + " Text: " + xmlHttp.responseText);
    			}
    		}
    	};
    }

    this.getLabeltexts = function(page, lang){
        if(xmlHttp != null){
            xmlHttp.open("GET", "/getLabelTexts?hidPage=" + page + "&rdbLang=" + lang, true);
            xmlHttp.send(null);
        }
    }
}
window.errors = new Array();
window.jsonLabeltexts = new LabelTextService;