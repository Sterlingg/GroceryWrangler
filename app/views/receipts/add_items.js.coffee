$('#selection-modal').modal('hide')
table_rows = "<%= j(render partial: '/receipt_items/item_table_entry', locals: { receipt_items: @new_receipt_items}) %>"
$('#receipts-table>tbody').append(table_rows)

items_to_update = <%= json_escape(@items_to_update) %>

for item in items_to_update
  $("#item_quantity_#{item['item_id']}").html("#{item['quantity']}")
