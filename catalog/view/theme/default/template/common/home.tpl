<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
<h1 style="display: none;"><?php echo $heading_title; ?></h1>
<?php echo $content_bottom; ?>

<?php
function get_instagram($user_id=327105497,$count=6,$width=80,$height=80){
    $url = 'https://api.instagram.com/v1/users/'.$user_id.'/media/recent/?access_token=315628192.cfab3d1.073b9041db354ed7a76e82a86ef2930e&count='.$count;
    // Creiamo una cache per velocizzare il caricamento e pesare meno sul server
    $cache = './system/cache/'.sha1($url).'.json';
    if(file_exists($cache) && filemtime($cache) > time() - 1000){
        // Se esiste un file di cache da meno di 1000 secondi, usa quello
        $jsonData = json_decode(file_get_contents($cache));
    } else {
        $jsonData = json_decode((file_get_contents($url)));
        file_put_contents($cache,json_encode($jsonData));
    }
    $result = '<div id="redesocial"><div id="caixainstagram"><div class="caixatopo"><img src="/catalog/view/theme/elegantcart/image/instagram.png" /></div><div id="caixabaixo"><ul class="media-grid">'.PHP_EOL;
    if(is_array($jsonData->data)){
    } else {
    }
    foreach ($jsonData->data as $key=>$value) {
$title = (!empty($value->caption->text))?' '.$value->caption->text:'...';
        $location = (!empty($value->location->name))?' presso '.$value->location->name:null;
$result .= "\t".'<li> <a href="'.$value->images->standard_resolution->url.'" rel="lightbox" title="'.htmlentities($title, ENT_QUOTES, "UTF-8").'"><img class="thumbnail" src="'.$value->images->low_resolution->url.'" width="'.$width.'" height="'.$height.'"></a></li>'.PHP_EOL;
    }
    $result .= '</ul></div></div>'.PHP_EOL;
    return $result;
}
echo get_instagram();
?>

<div class="fb-like-box" data-header="false" data-height="260" data-href="http://www.facebook.com/facebook" data-show-faces="true" data-stream="false" data-width="665" id="resto" style="float:left;background:#eeeeee;width:665px;height:260px;margin-left:15px;">&nbsp;</div>
</div>

</div>
<?php echo $footer; ?>