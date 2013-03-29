<h1 class="heading1">
  <span class="maintext"><?php echo $heading_title; ?></span>
  <span class="subtext"></span>
</h1>

<?php if ($success) { ?>
<div class="alert alert-success">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<?php echo $success; ?>
</div>
<?php } ?>

<?php if ($error_warning) { ?>
<div class="alert alert-error">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<?php echo $error_warning; ?>
</div>
<?php } ?>

<div class="container-fluid">

    <?php if ($coupon_status) { ?>
    <h4 class="heading4"><?php echo $text_coupon; ?></h4>
	<div class="registerbox">
		<?php echo $form0['form_open']; ?>
		<div class="form-inline">
			<label class="checkbox"><?php echo $entry_coupon; ?></label>
		    <?php echo $form0['coupon']; ?>
		    <?php echo $form0['submit']; ?>
		</div>
		</form>
	</div>
    <?php } ?>

	<?php echo $form['form_open']; ?>

	<?php if( $shipping_methods ) { ?>			
	<h4 class="heading4"><?php echo $text_shipping_method; ?></h4>	
	<p><?php echo $text_shipping_methods; ?></p>		
	<div class="registerbox">		
        <table class="table table-striped table-bordered">
        <?php
	      foreach ($shipping_methods as $shipping_method) { ?>
          <tr>
            <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
          </tr>
          <?php if (!$shipping_method['error']) { ?>
          <?php foreach ($shipping_method['quote'] as $quote) { ?>
			  <tr>
				<td width="5%"><label for="shipping_shipping_method<?php echo $quote['id']; ?>"><?php echo $quote['radio']; ?></label></td>
				<td><label for="shipping_shipping_method<?php echo $quote['id']; ?>" style="cursor: pointer;"><?php echo $quote['title']; ?></label></td>
				<td align="right"><label for="<?php echo $quote['id']; ?>" style="cursor: pointer;"><?php echo $quote['text']; ?></label></td>
			  </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
          </tr>
          <?php } ?>
        <?php } ?>
        </table>
	</div>
	<?php } ?>
	<?php echo $this->getHookVar('shipping_extensions_hook'); ?>
	
	<?php if( $payment_methods ) { ?>			
	<h4 class="heading4"><?php echo $text_payment_method; ?></h4>	
	<p><?php echo $text_payment_methods; ?></p>		
	<div class="registerbox payment_palce_holder"></div>	
		<div style="display: none;" id="hidden_payments">
		        <?php if($payment_methods) { 
		        	foreach ($payment_methods as $ship_name => $payment_methods_per_shipping) { ?>
		        <div class="payment_group <?php echo $ship_name ?>">
		        <table class="table table-striped table-bordered">
		          <?php foreach ($payment_methods_per_shipping as $payment_method) { ?>
		          <tr>
		            <td width="1"><?php echo $payment_method['radio']; ?></td>
		            <td><label for="guest_payment_method<?php echo $payment_method['id']; ?>" style="cursor: pointer;"><?php echo $payment_method['title']; ?></label></td>
		          </tr>
		          <?php } ?>
		        </table>
		        </div>
		        <?php } } ?>
				<?php echo $this->getHookVar('payment_extensions_hook'); ?>			          
		</div>	
	<?php } ?>
	
	<?php echo $this->getHookVar('order_attributes'); ?>

	<h4 class="heading4"><?php echo $text_comments; ?></h4>	
	<div class="registerbox">		
		<div class="content">
			<?php echo $form['comment']; ?>
     	</div>
		
		<div class="control-group">
			<div class="controls">
    			<div class="form-inline mt20 mb20">
    			<?php echo $this->getHookVar('buttons_pre'); ?>
				<?php echo $buttons; ?>
				<?php echo $this->getHookVar('buttons_post'); ?>
    			</div>	
    		</div>
		</div>			
	</div>
	
	</form>
</div>

<script type="text/javascript">		
	if ($("input[name=shipping_method]:checked").length > 0) {
		var shp_name = '';
		shp_name = $("input[name=shipping_method]:checked").val().split('.');
		shp_name = shp_name[0];
		show_payment(shp_name);	

	} else if ( $('#active_shippings').length == 0 ) {
		//no shipping at all show all payments
		show_payment('no_shipping');
	}
		
	$('.radio_element input:[name=shipping_method]').click( function(){
		var selection = $(this).val().split('.');
		//hide and unselect other methods. 
		show_payment(selection[0]);
	} );	
	
	function show_payment( shp_name ) {
		$('#active_payments').show();
		$('.payment_palce_holder').html('');
		$('.payment_palce_holder').html( $('#hidden_payments .'+shp_name).html() );
	}
</script>