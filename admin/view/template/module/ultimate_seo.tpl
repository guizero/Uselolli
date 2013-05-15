<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div><!-- breadcrumb -->
		
	<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>	
	
	<div class="box">
		
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div><!-- end of .heading -->

		<div class = "content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
			<table class = "form">
				<tr>
					<td><?php echo $entry_meta_num; ?><br /><span class = "help"><?php echo $entry_meta_num_description; ?></span></td>
					<td>
					<input type="text" name="useo_meta_num" value="<?php echo $useo_meta_num; ?>" />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_auto_meta; ?><br /><span class = "help"><?php echo $entry_auto_meta_description; ?></span></td>
					<td>
					<input type="checkbox" name="useo_auto_meta" value = "yes" <?php echo $useo_auto_meta; ?>  />
					</td>
				</tr>
			</table>
			</form>
		</div> <!-- end of .content -->
		
	</div><!-- end of .box -->

</div> <!-- end of #content -->
