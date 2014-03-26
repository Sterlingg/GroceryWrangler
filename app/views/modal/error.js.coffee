# TODO: Properly format the error response. 
$(".modal-title").html "We have some problems :(";
$(".modal-body").html "<%= j(render 'shared/modal_error', locals: {item_with_error: @new_receipt_item}) %>";
