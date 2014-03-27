$(".modal-body").html "<%= j(render 'selection_dialog', locals: {categories: @categories, receipt: @receipt}) %>";
$(".modal-title").html "Select a category";
