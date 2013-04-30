<?php if (count($currencies) > 1) { ?>

<script type="text/javascript">
$(document).ready(function(){	
		co_w = $('#c_options').width();
		$('#c_switcher').css('width',(co_w + 10)+'px');
		$('#c_switcher').hover(function(){
			$('#c_options').slideDown(200);
		},function(){
			$('#c_options').slideUp(200);
		});
});		
</script>  

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div id="currency">
  		<div id="c_switcher">
     	  <?php foreach ($currencies as $currency) { ?>           
          <?php if ($currency['code'] == $currency_code) { ?>
          <span class="c_selected"><?php echo $currency['title'];?></span>
          <?php } ?> 
          <?php } ?> 		
          <div id="c_options" style="display: none;">
    	  <?php foreach ($currencies as $currency) { ?>                   
                <a onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>').submit(); $(this).parent().parent().parent().parent().submit();"><?php echo $currency['title']; ?></a>
          <?php } ?>      
          </div>
         </div>
    <input type="hidden" name="currency_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />          
  </div>
</form>
<?php } ?>
