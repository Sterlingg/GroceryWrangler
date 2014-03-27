$(".modal-body").html "<%= j(render 'selection_dialog', {items: @items, receipt: @receipt}) %>";
$(".modal-title").html "Select an item";
