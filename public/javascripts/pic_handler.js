$(document).ready(function() {
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
