<?php echo $header; ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<!--<?php echo $column_left; ?>--><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h2><?php echo $text_my_account; ?></h2>
  <div class="minhaconta">
    <div class="minhaconta_holder">
      <div><a href="<?php echo $edit; ?>"><img src="/catalog/view/theme/elegantcart/image/meusdados.png"></a></div>
      <div style="text-align:center"><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></div>
    </div>
    <div class="minhaconta_holder">
      <div><a href="<?php echo $password; ?>"><img src="/catalog/view/theme/elegantcart/image/minhasenha.png"></a></div>
      <div style="text-align:center"><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></div>
    </div>
    <div class="minhaconta_holder">
      <div><a href="<?php echo $address; ?>"><img src="/catalog/view/theme/elegantcart/image/meusenderecos.png"></a></div>
      <div style="text-align:center"><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></div>
    </div>
    <div class="minhaconta_holder">
      <div><a href="<?php echo $wishlist; ?>"><img src="/catalog/view/theme/elegantcart/image/meusfavoritos.png"></a></div>
      <div style="text-align:center"><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></div>
    </div>
    <div class="minhaconta_holder">
      <div><a href="<?php echo $order; ?>"><img src="/catalog/view/theme/elegantcart/image/meuspedidos.png"></a></div>
      <div style="text-align:center"><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></div>
    </div>  
  </div>

  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?> 