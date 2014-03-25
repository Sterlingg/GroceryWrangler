$(".modal-body").html "<%= j(render 'shared/category_selection', locals: {categories: @categories, receipt: @receipt}) %>";
$(".modal-title").html "Select a category";
