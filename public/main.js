$(document).ready(function(){
	$('#submit').click(function(){
		send_charge(
			$('.charge').attr('id'),
			$('.charge option:selected').val(),
			$('.description').val(),
			$('.amount').val()
			);
	});
});

function send_charge(space, membership, description, amount) {
	data = {
		description: description,
		amount: amount
	};
	
	$.post('/spaces/'+space+'/charge/'+membership, data, function(response){
		response = $.parseJSON(response);
		
		if(response.errors) {
			show_notification(response.message, 'error');
			$(response.errors).each(function() {
				send_notification(this, 'error');
			});
		} else
		  show_notification(response.message, 'success');
		
	});
};

function show_notification(message, type) {
	if(type != 'sucess' || type != 'info' || type != 'warning' || type != 'error')
	  type = type || 'success';
	$('<div>'+message+'</div>').appendTo('.notifications').hide().addClass(type).fadeIn(300, function(){
		$(this).fadeOut(2000, function(){
			$(this).remove();
		});
		return true;
	});
	return false;
};

