<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div><!-- breadcrumb -->
	<?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error) { ?>
  <div class="warning"><?php echo $error; ?></div>
  <?php } ?>
		
	<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>	
	
	<div class="box">
		<div style="text-align:right;margin-bottom:5px;">To support <a style = "color:rgb(249,0,0)" target="_blank" href = "http://codeinspires.com/projects/super-seo-language-and-friendly-urls-opencart-extension">Super Seo Language.</a> follow us on <a href = "http://facebook.com/codeinspires" target="_blank">Facebook</a> or <a href = "http://twitter.com/codeinspires" target="_blank">Twitter</a> or <a href = "http://www.opencart.com/index.php?route=extension/extension/info&extension_id=8897" target = "_blank">give a nice rating on opencart</a> or <input type = "checkbox" name = "codeinspire_support" <?php if(isset($codeinspires) && $codeinspires) echo "checked"; ?> onclick = "window.location='<?php echo $codeinspires_url ?>'"> give a backlink on your footer. Designed by <a href = "http://www.codeinspires.com" target="_blank" style = "color:rgb(249,0,0)">Codeinspires</a>.</div>	
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div><!-- end of .heading -->

		<div class = "content">
		<h4 style = "font-size:1.0em;"><?php echo $description; ?></h4>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
			<table class = "form">
			<thead>
				<tr>
				<td><strong><?php echo $description_route; ?></strong></td>
				<td colspan="2"><strong><?php echo $description_url; ?></strong></td>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td><input type = "text" name = "route" /></td>
				<td colspan="2"><input type = "text" name = "url" /></td>
			</tr>
				<?php foreach($super_seo_urls as $url) { ?>
					<tr>
						<td><?php echo $url['query']; ?></td>
						<td><?php echo $url['keyword']; ?></td>
						<td><a href = "<?php echo $url['delete']; ?>" class = "button"><?php echo $button_delete; ?></a></td>
					</tr>
				<?php } ?>
				</tbody>
			</table>
			</form>
		</div> <!-- end of .content -->
		
	</div><!-- end of .box -->

</div> <!-- end of #content -->

