// ADD THIS: js handlers + all naive uploadify files

 $(document).ready(function() {
    $('#upload').click(function(event){
      event.preventDefault();
		});       
  $('#picture_submit').click(function(event){
    event.preventDefault();
    $('#upload').uploadifyUpload();
	}); 
	$('#crop_trigger').live("click", function() {
		$("#crop_trigger").hide();
		$("#crop_submit").show();
	
	  jQuery('#cropbox').Jcrop({
	  	onChange: update_crop,
	  	onSelect: update_crop,
			aspectRatio: 1,
			minSize: [100,100]
		});
	});
	
	$('#crop_submit').live("click", function(event) {
		event.preventDefault();
		$.ajax({
			type: "POST",
		  url: $('#crop_form').attr('action'),
		  data:  $('#crop_form').serialize(),
		  success: function(data) {
		    $.ajax({
					type: "GET",
					url: "/remote/show_crop/"});
		  }
		});
	}); 
});	  
