<div class="camera_white_skin camera_wrap" id="camera_wrap">
    <?php foreach ($banners as $banner) { ?>
	    <?php if ($banner['link']) { ?>
	    <div data-src="<?php echo $banner['image']; ?>" data-thumb="<?php echo $banner['image']; ?>"  data-link="<?php echo $banner['link']; ?>"></div>
	    <?php } else { ?>
	    <div data-src="<?php echo $banner['image']; ?>" data-thumb="<?php echo $banner['image']; ?>"></div>
	    <?php } ?>
    <?php } ?>
</div>

<div class="h15"></div>

<script type="text/javascript"><!--
$('#camera_wrap').camera({
	height: '41%',
	thumbnails: true,
	loader: false,
	hover: true,
	time: 6000,
	transPeriod: 1200
	
});
--></script>