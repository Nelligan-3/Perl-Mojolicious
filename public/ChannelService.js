function ChannelService(){
	var xmlHttp = null;
	if (window.XMLHttpRequest) {
		// IE7+, Firefox, Seamonkey, Opera, Safari, Chrome
		xmlHttp = new XMLHttpRequest();
	} else {
		// old Internet Explorer
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}

    if(xmlHttp != null){
    	xmlHttp.onreadystatechange = function() {
    		if (xmlHttp.readyState == 4) {
    			if (xmlHttp.status == 200) {
    				if (xmlHttp.responseText != "") {
    					window.jsonObject = eval("(" + xmlHttp.responseText + ")");
    					for (window.channel in window.jsonObject) {
    						window.alink = document.createElement("a");
    						window.href = document.createAttribute("href");
    						window.href.nodeValue = "/messages?hidLang=" + document.getElementById("hidLang").value + "&hidChannelId=" + window.channel;
    						window.alink.setAttributeNode(window.href);
    						window.tn = document.createTextNode(window.jsonObject[window.channel]);
    						window.alink.appendChild(window.tn);
    						document.getElementById("divChannels").appendChild(window.alink);
    						document.getElementById("divChannels").appendChild(document.createElement("br"));
    					}
    				}
    			} else {
    				alert("AJAX failure! Status: " + xmlHttp.status + " Text: " + xmlHttp.responseText);
    			}
    		}
    	};
    }

    this.getChannels = function(lang){
        if(xmlHttp != null){
            xmlHttp.open("GET", "/getChannels?hidLang=" + lang, true);
            xmlHttp.send(null);
        }
        //window.setInterval(jsonChannels.getChannels(), 1000);
        //window.setTimeOut(jsonChannels.getChannels(), 1000);
    }

	this.validate = function() {
		if(document.getElementById("txtName").value == ""){
			alert(window.errors[1]);
		}else{
			document.getElementById("frmChannel").submit();
		}
	}
}

window.jsonChannels = new ChannelService;