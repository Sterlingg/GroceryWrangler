$('#selection-modal').modal('hide')

# Add the items to the table.
table_rows = "<%= j(render partial: '/receipt_items/item_table_entry', locals: { receipt_items: @new_receipt_items}) %>"
$('#receipt-item-table>tbody').append(table_rows)

items_to_update = <%= @items_to_update %>

for item in items_to_update
  $("#item_quantity_#{item['item_id']}").html("#{item['quantity']}")

# Update the receipt total.
receipt_total_element = $('#receipt-total') 

new_total = <%= @receipt.total %>

receipt_total_element.html("$" +  new_total.toFixed(2))

console.log(receipt_total_element)
console.log(new_total)
