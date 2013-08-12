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
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><span class="required">*</span><?php echo $entry_enable_module; ?></td>
          <td><?php if ($settings_enable) { ?>
            <input type="radio" name="oc_option_image_settings[enable]" value="1" checked="checked" />
            <?php echo $text_yes; ?>
            <input type="radio" name="oc_option_image_settings[enable]" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="oc_option_image_settings[enable]" value="1" />
            <?php echo $text_yes; ?>
            <input type="radio" name="oc_option_image_settings[enable]" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?></td>
        </tr>
       
        <tr>
          <td><span class="required">*</span><?php echo $entry_additional_images; ?></td>
          <td><?php if ($settings_additional_images) { ?>
            <input type="radio" name="oc_option_image_settings[additional_images]" value="1" checked="checked" />
            <?php echo $text_yes; ?>
            <input type="radio" name="oc_option_image_settings[additional_images]" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="oc_option_image_settings[additional_images]" value="1" />
            <?php echo $text_yes; ?>
            <input type="radio" name="oc_option_image_settings[additional_images]" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?></td>
        </tr>
       
       
       
       
       
       
       
       
       
   </table>
    </form>
  </div>
</div>
<?php echo $footer; ?>