receipt_item_id = <%= @receipt_item.id %>

quantity_removed = <%= @receipt_item.quantity %>
price_removed =  <%= @receipt_item.price %> 
# Remove the row the user is deleting.
$("#receipt-table-item-#{receipt_item_id}").remove()

receipt_total_element = $('#receipt-total')
new_rec_total = <%= @receipt.total %>

receipt_total_element.html("$" + new_rec_total.toFixed(2))
