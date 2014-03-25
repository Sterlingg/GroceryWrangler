$(".modal-body").html "<%= j(render 'shared/item_selection', locals: {items: @items, receipt: @receipt}) %>";
$(".modal-title").html "Select an item";
