$(document).ready(function() {
	//POPUP COLORBOX
	if (document.cookie.indexOf('visited=true') === -1) {
	    var expires = new Date();
	    expires.setDate(expires.getDate()+30);
	    document.cookie = "visited=true; expires="+expires.toUTCString();
	    $.colorbox({inline:true,  href:"#modal-conteudo", opacity:"0.5", transition:"fade"});
	}


		var searcKey = $("#mce-EMAIL");
			placeHolderFix(searcKey);
			var searcKey2 = $("#mce-NAME");
			placeHolderFix(searcKey2);
	
			var $form = $('form');

	    
	        $('#mc-embedded-subscribe').bind('click', function ( event ) {
	            if ( event ) event.preventDefault();				           
	            register($form);
	        });

	/* Search */
	$('.button-search').bind('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';
				 
		var search = $('input[name=\'search\']').attr('value');
		
		if (search) {
			url += '&search=' + encodeURIComponent(search);
		}
		
		location = url;
	});
	
	$('#header input[name=\'search\']').bind('keydown', function(e) {
		if (e.keyCode == 13) {
			url = $('base').attr('href') + 'index.php?route=product/search';
			 
			var search = $('input[name=\'search\']').attr('value');
			
			if (search) {
				url += '&search=' + encodeURIComponent(search);
			}
			
			location = url;
		}
	});
	
	/* Ajax Cart */
	$('#cart > .heading a').live('mouseenter', function() {
		$('#cart').addClass('active');
		
		$('#cart').load('index.php?route=module/cart #cart > *');
		
		$('#cart').live('mouseleave', function() {
			$(this).removeClass('active');
		});
	});
	
	/* Mega Menu */
	$('#menu ul > li > a + div').each(function(index, element) {
		// IE6 & IE7 Fixes
		if ($.browser.msie && ($.browser.version == 7 || $.browser.version == 6)) {
			var category = $(element).find('a');
			var columns = $(element).find('ul').length;
			
			$(element).css('width', (columns * 143) + 'px');
			$(element).find('ul').css('float', 'left');
		}		
		
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();
		
		i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());
		
		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// IE6 & IE7 Fixes
	if ($.browser.msie) {
		if ($.browser.version <= 6) {
			$('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');
			
			$('#column-right + #content').css('margin-right', '195px');
		
			$('.box-category ul li a.active + ul').css('display', 'block');	
		}
		
		if ($.browser.version <= 7) {
			$('#menu > ul > li').bind('mouseover', function() {
				$(this).addClass('active');
			});
				
			$('#menu > ul > li').bind('mouseout', function() {
				$(this).removeClass('active');
			});	
		}
	}
	
	$('.success img, .warning img, .attention img, .information img').live('click', function() {
		$(this).parent().fadeOut('slow', function() {
			$(this).remove();
		});
	});	
});

function getURLVar(key) {
	var value = [];
	
	var query = String(document.location).split('?');
	
	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');
			
			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}
		
		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
} 

function addToCart(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 1;

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.success').fadeIn('slow');
				
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 

				window.location.href = '/sacola';  // redireciona para o carrinho //
			}	
		}
	});
}
function addToWishList(product_id) {
	$.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.success').fadeIn('slow');
				
				$('#wishlist-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}	
		}
	});
}

function addToCompare(product_id) { 
	$.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.success').fadeIn('slow');
				
				$('#compare-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
}

$(function(){
					$('input[name="postcode"]').blur(function(){
						var cep = $.trim($('input[name="postcode"]').val().replace('-', ''));
		
						$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+cep, function(){
							if(resultadoCEP["resultado"] == "1"){
								$('input[name="address_1"]').val(unescape(resultadoCEP["tipo_logradouro"])+" "+unescape(resultadoCEP["logradouro"]));
								$('input[name="address_2"]').val(unescape(resultadoCEP["bairro"]));
								$('input[name="city"]').val(unescape(resultadoCEP["cidade"]));

								$('select[name="country_id"]').find('option[value="30"]').attr('selected', true);
								$.post('index.php?route=account/register/estado_autocompletar&estado=' + unescape(resultadoCEP['uf']), function(zone_id){
									$.ajax({
										url: 'index.php?route=account/register/country&country_id=30',
										dataType: 'json',
										beforeSend: function() {
											$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/elegantcart/image/loading.gif" alt="" /></span>');
										},
										complete: function() {
											$('.wait').remove();
										},			
										success: function(json) {
											if (json['postcode_required'] == '1') {
												$('#postcode-required').show();
											} else {
												$('#postcode-required').hide();
											}
	
											var html = '<option value=""><?php echo $text_select; ?></option>';
	
											if (json['zone'] != '') {
												for (i = 0; i < json['zone'].length; i++) {
													html += '<option value="' + json['zone'][i]['zone_id'] + '"';
													
													if (json['zone'][i]['zone_id'] == zone_id) {
														html += ' selected="selected"';
													}
									
													html += '>' + json['zone'][i]['name'] + '</option>';
												}
											} else {
												html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
											}
	
											$('select[name=\'zone_id\']').html(html);
										}
									});
								});
							}
						});
					});
				});	

//facebook

(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/pt_BR/all.js#xfbml=1&appId=488143071223582";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

//mask do cep

function MM_formtCep(e,src,mask) {
        if(window.event) { _TXT = e.keyCode; } 
        else if(e.which) { _TXT = e.which; }
        if(_TXT > 47 && _TXT < 58) { 
  var i = src.value.length; var saida = mask.substring(0,1); var texto = mask.substring(i)
  if (texto.substring(0,1) != saida) { src.value += texto.substring(0,1); } 
     return true; } else { if (_TXT != 8) { return false; } 
  else { return true; }
        }
}

function register($form) {
			    $.ajax({
			        type: $form.attr('method'),
			        url: $form.attr('action'),
			        data: $form.serialize(),
			        cache       : false,
			        dataType    : 'json',
			        contentType: "application/json; charset=utf-8",
			        error       : function(err) { alert("Could not connect to the registration server. Please try again later."); },
			        success     : function(data) {
			            if (data.result != "success") {
			            	if (data.msg.indexOf("inscrito") !== -1) {
			                alert("Já está inscrito!");
			            }
			            else 
			            	alert(data.msg);
			            } else {
			               $.colorbox({inline:true,  href:"#modal-sucesso", opacity:"0.5", transition:"fade"});
			            }
			        }
			    });
			}

			function placeHolderFix(element){
			        var originalValue;
			        var is_chrome = window.chrome;
			        if(is_chrome){
			                $(element).val("");
			        }

			    if(navigator.appVersion.indexOf("MSIE") !== -1){
			            originalValue = $(element).val();
			      }else{
			            originalValue = $(element).attr('placeholder');
			    }


			    var placeAttr = $(element).attr('placeholder');
			    $(element).focus(function() {
			                    $(element).attr('placeholder', '');

			                    if(navigator.appVersion.indexOf("MSIE") !== -1 && $(element).val() == originalValue){
			                            $(element).val(""); 
			                    }
			            });
			    $(element).blur(function(){
			            $(element).attr('placeholder', placeAttr);
			            if(navigator.appVersion.indexOf("MSIE") !== -1 && $(element).val() == ""){
			                    $(element).attr('value', originalValue);
			            }
			    });
			}