<?php echo $header; ?>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table id="module" class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_store_id; ?></td>                             
            <td class="left"><?php echo $entry_status; ?></td>  
            <td class="left"><?php echo $entry_banner_position; ?></td>          
          </tr>
        </thead>

        <tbody id="module-row">
          <tr>
            <td class="left"><input type="text" name="ownedit_module[0][store_id]" value="<?php if(isset($modules)){echo $modules[0]['store_id'];}else{echo '';} ?>" size="20" /></td>          
            <td class="left"><select name="ownedit_module[0][status]">
                <?php if (isset($modules)) { 
                if ($modules[0]['status']==1){
                ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php }} 
                else{ ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php }                
                ?>
              </select></td>
             <td class="left"><input alt="Enter the CSS class name to position the banner on the checkout page" type="text" name="ownedit_module[0][position_class]" value="<?php if(isset($modules)){echo $modules[0]['position_class'];}else{echo '';} ?>" size="20" /></td>        
          </tr>
        </tbody>
      </table>
      <p><a href="https://www.ownedit.com/?ref=7b6f1c3973" target="_blank">Sign up</a> for free</p>
      <p><b>Store ID:</b>  A store ID is generated for each store you add to Owned it. <b>To obtain the Store ID, Login to Owned it and navigate to the Store Settings tab. [Path: Settings (top right) > Account Settings > Store Settings]</b></p>
      <p><b>CSS Class:</b> A call-to-action button/ banner can be placed on the order confirmation page (/catalog/view/theme/{theme_name}/template/common/success.tpl). Clicking on the banner image will trigger the Owned it frame, enabling the customer to interact with the campaign.</p>
      <p>Create a 'div' element on the checkout page and give it a unique “class” attribute. Position the 'div' element at the location where the banner should appear.</p>
      
    </form>
  </div>
</div>
