<?php if ($error) { ?>
<div class="warning"><?php echo $error; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<table class="list">
  <thead>
    <tr>
      <td class="left"><b><?php echo $column_date_added; ?></b></td>
      <td class="left"><b><?php echo $column_comment; ?></b></td>
      <td class="left"><b><?php echo $column_status; ?></b></td>

				<!-- Begin Track Trace -->
				<td class="left"><b><?php echo $column_trackcode; ?></td>
				<!-- Termina Rastreamento Correios -->
			
			
      <td class="left"><b><?php echo $column_notify; ?></b></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($histories) { ?>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="left"><?php echo $history['date_added']; ?></td>
      <td class="left"><?php echo $history['comment']; ?></td>
      <td class="left"><?php echo $history['status']; ?></td>

				<!-- Começa Rastreamento Correios -->
				<?php if ($history['carrier'] == 'DHL') { ?>
				<td class="left"><img src="view/image/dhl_logo_small.gif" hspace="3" align="absmiddle" /><a href='<?php echo $history['trackcode']; ?>' target="_blank"><b onmouseover="this.style.color='red'" onmouseout="this.style.color=''"><?php echo $history['tnt_track']; ?></b></a></td>
				<?php } else if ($history['carrier'] == 'PostNL'){ ?>
				<td class="left"><img src="view/image/Correios_logo_small.gif" hspace="3" align="absmiddle" /><a href='<?php echo $history['trackcode']; ?>' target="_blank"><b onmouseover="this.style.color='red'" onmouseout="this.style.color=''"><?php echo $history['tnt_track']; ?></b></a></td>
				<?php } else { ?><td class="left"><span class="help"><?php echo $text_notracking; ?></span></td>
				<?php } ?>
				<!-- Termina Rastreamento Correios -->
			
			
      <td class="left"><?php echo $history['notify']; ?></td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
      <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="pagination"><?php echo $pagination; ?></div>
