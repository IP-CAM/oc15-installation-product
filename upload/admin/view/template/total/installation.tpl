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
      <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_product; ?></td>
            <td><input type="text" name="product" value="" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><div id="installation-product" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($products as $product) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div id="installation-product<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['name']; ?> <img src="view/image/delete.png" alt="" />
                  <input type="hidden" value="<?php echo $product['product_id']; ?>" />
                </div>
                <?php } ?>
              </div>
              <input type="hidden" name="installation_product" value="<?php echo $installation_product; ?>" /></td>
          </tr>
        </table>
        <table class="form">
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="installation_status">
                <?php if ($installation_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="installation_sort_order" value="<?php echo $installation_sort_order; ?>" size="1" /></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
  delay: 500,
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
      dataType: 'json',
      success: function(json) {   
        response($.map(json, function(item) {
          return {
            label: item.name,
            value: item.product_id
          }
        }));
      }
    });
  }, 
  select: function(event, ui) {
    $('#installation-product' + ui.item.value).remove();
    
    $('#installation-product').append('<div id="installation-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" value="' + ui.item.value + '" /></div>');

    $('#installation-product div:odd').attr('class', 'odd');
    $('#installation-product div:even').attr('class', 'even');
    
    data = $.map($('#installation-product input'), function(element){
      return $(element).attr('value');
    });
            
    $('input[name=\'installation_product\']').attr('value', data.join());
          
    return false;
  },
  focus: function(event, ui) {
        return false;
    }
});

$('#installation-product div img').live('click', function() {
  $(this).parent().remove();
  
  $('#installation-product div:odd').attr('class', 'odd');
  $('#installation-product div:even').attr('class', 'even');

  data = $.map($('#installation-product input'), function(element){
    return $(element).attr('value');
  });
          
  $('input[name=\'installation_product\']').attr('value', data.join()); 
});
//--></script>
<?php echo $footer; ?>