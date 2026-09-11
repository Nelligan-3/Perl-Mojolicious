function MessageService(){
	var xmlHttp = null;
	if (window.XMLHttpRequest) {
		// IE7+, Firefox, Seamonkey, Opera, Safari, Chrome
		xmlHttp = new XMLHttpRequest();
	} else {
		// old Internet Explorer
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}

    if(xmlHttp != null){
        xmlHttp.onreadystatechange = function(){
            if(xmlHttp.readyState == 4){
                if(xmlHttp.status == 200){
                    if(xmlHttp.responseText != ""){
                        window.jsonObject = eval("(" + xmlHttp.responseText + ")");
                        for(window.message in window.jsonObject){
                            window.tn = document.createTextNode(window.jsonObject[window.message].accountname + " [" + window.jsonObject[window.message].time + "]:");
                            document.getElementById("divMessages").appendChild(window.tn);
                            document.getElementById("divMessages").appendChild(document.createElement("br"));
                            window.par = document.createElement("p");
                            window.tn = document.createTextNode(window.jsonObject[window.message].message);
                            window.par.appendChild(window.tn);
                            document.getElementById("divMessages").appendChild(window.par);
                            document.getElementById("divMessages").appendChild(document.createElement("br"));
                        }
                    }
                }else{
                    alert("AJAX failure! Status: " + xmlHttp.status + " Text: " + xmlHttp.responseText);
                }
            }
        };
    }

    this.getMessages = function(channelId){
        if(xmlHttp != null){
            xmlHttp.open("GET", "/getMessages?hidChannelId=" + channelId, true);
            xmlHttp.send(null);
        }
        //window.setInterval(jsonMessages.getMessages(channelId), 1000);
        //window.setTimeOut(jsonMessages.getMessages(channelId), 1000);
    }

	this.validate = function() {
		if(document.getElementById("txtMessage").value == ""){
			alert(window.errors[1]);
		}else{
			document.getElementById("frmMessage").submit();
		}
	}
}

window.jsonMessages = new MessageService;