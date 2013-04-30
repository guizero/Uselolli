if(!document.getElementById('fb-root')){
var fbdiv = document.createElement('div');
fbdiv.setAttribute('id', 'fb-root');
	if(document.body != null){ 
		document.body.appendChild(fbdiv);
	}
}

(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/pt_BR/all.js#xfbml=1&appId=488143071223582";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));