receipt_item_id = <%= @receipt_item.id %>

quantity_removed = <%= @receipt_item.quantity %>
price_removed =  <%= @receipt_item.price %> 
# Remove the row the user is deleting.
$("#receipt-table-item-#{receipt_item_id}").remove()

receipt_total_element = $('#receipt-total')
old_total = parseFloat receipt_total_element.html().substring(1)

receipt_total_element.html("$" + (old_total - (quantity_removed * price_removed)).toFixed(2))
