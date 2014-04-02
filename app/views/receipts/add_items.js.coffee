$('#selection-modal').modal('hide')

# Add the items to the table.
table_rows = "<%= j(render partial: '/receipt_items/item_table_entry', locals: { receipt_items: @new_receipt_items}) %>"
$('#receipt-item-table>tbody').append(table_rows)

items_to_update = <%= json_escape(@items_to_update) %>

for item in items_to_update
  $("#item_quantity_#{item['item_id']}").html("#{item['quantity']}")

# Update the receipt total.
receipt_total_element = $('#receipt-total') 

old_total = parseFloat receipt_total_element.html().substring(1)

receipt_total_element.html("$" + (old_total + <%= @total_added %>).toFixed(2))
