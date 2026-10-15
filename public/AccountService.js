function AccountService(){
	this.validate = function() {
		if(document.getElementById("txtNewAccountname").value == "" || document.getElementById("txtNewPassword").value == "" || document.getElementById("txtNewPassword2").value == "" || document.getElementById("txtNewFirstname").value == "" || document.getElementById("txtNewLastname").value == "" || document.getElementById("txtNewPassword").value != document.getElementById("txtNewPassword2").value){
			alert(window.errors[1]);
		}else{
			document.getElementById("frmAccount").submit();
		}
	}
}

window.accounts = new AccountService;
