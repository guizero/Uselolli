var jQueryScriptOutputted = false;
function init2JQuery() {
    
    //if the jQuery object isn't available
    if (typeof(jQuery) == 'undefined') {
    
    
        if (! jQueryScriptOutputted) {
            //only output the script once..
            jQueryScriptOutputted = true;
            
            //output the script (load it from jquery)
            document.write("<scr" + "ipt type=\"text/javascript\" src=\"http://code.jquery.com/jquery-1.9.1.min.js\"></scr" + "ipt>");
        


    }
        setTimeout("initJQuery()", 50);
     //alert( "si lo cargo");
    } else {
                        
        $(function() {  
         //alert( "NO ES NESESARIO");
     //do anything that needs to be done on document.ready
        });
    }
            
}

init2JQuery();

window.fbAsyncInit = function () {

  FB.init({
    appId:    '488143071223582',
    cookie:   true,
    oauth:    true
  });
  
  var fb_busy = false;

  var nPage = window.location.pathname;
  nPage = nPage.substring(nPage.lastIndexOf('/') + 1);
        

  $('#fb-login, #fb-login2').on('click',function () {
    if (fb_busy) return;
    fb_busy = true;

    $('#login-fb-waiting-text').text('Entrando pelo Facebook...');

    $('#login-btr').hide('fade', 300);
    $('#login-fb-waiting').delay(300).show('fade', 250).delay(400);

    FB.login(function (res) {
      $('#login-fb-waiting').queue(function (next) {
        if (res.status == 'connected' && res.authResponse != null) {
          $('#login-fb-waiting-text').hide('fade', 250, function () {
            $(this).text('Acessando a conta...').show('fade', 250).delay(400).queue(function (next2) {
              //$('#mode').val('facebook-auto');
              if (nPage == 'finalizar') {
                document.location.href='https://www.uselolli.com/index.php?route=account/fbjsconnect&pagina=finalizar';
              }
              else {
                document.location.href='https://www.uselolli.com/index.php?route=account/fbjsconnect';
              }
              //$('#login-btr').submit();

              next2();
            });
          });
        }
        else {
          $('#login-fb-waiting-text').hide('fade', 300, function () {
            $(this).text('Conexão com o Facebook cancelada.').show('fade', 250).delay(400).queue(function (next2) {
              $('#login-fb-waiting').hide('fade', 300, function () {
                $('#login-btr').show('fade', 400, function () { fb_busy = false; });
              });

              next2();
            });
          });
        }

        next();
      });
    }, {
      scope: 'email,user_birthday,user_location,user_hometown'
    });
  });
};

$(function () {
  var e = document.createElement('script'); e.type = 'text/javascript'; e.async = true;
  e.src = 'https:' + '//connect.facebook.net/en_US/all.js';
  $('#fb-root').append(e);
});