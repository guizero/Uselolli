<?php if (count($languages) > 1) { ?>

<script type="text/javascript">
$(document).ready(function(){	
		l_w = $('#l_options').width();
		$('#l_switcher').css('width',(l_w + 10)+'px');
		$('#l_switcher').hover(function(){
			$('#l_options').slideDown(200);
		},function(){
			$('#l_options').slideUp(200);
		});
});		
</script>  

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div id="language">
  		<div id="l_switcher">
     	  <?php foreach ($languages as $language) { ?>          
          <?php if ($language['code'] == $language_code) { ?>
          <span class="l_selected"><?php echo $language['name'];?></span>
          <?php } ?> 
          <?php } ?> 		
          <div id="l_options" style="display: none;">
    	  <?php foreach ($languages as $language) { ?>                   
                <a onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>').submit(); $(this).parent().parent().parent().parent().submit();"><?php echo $language['name']; ?></a>
          <?php } ?>      
          </div>
         </div>
    <input type="hidden" name="language_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />          
  </div>
</form>
<?php } ?>