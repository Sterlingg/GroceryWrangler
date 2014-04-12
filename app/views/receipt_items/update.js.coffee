# Update the quantity and price.
item_id = <%= @receipt_item.id %>
new_quantity = <%= @receipt_item.quantity %>
new_price =  <%= @receipt_item.price %>
old_quantity =  <%= @old_quantity %>
old_price = <%= @old_price %>
$("#item_quantity_#{item_id}").html(<%= @receipt_item.quantity %>)
$("#item_price_#{item_id}").html(<%= @receipt_item.price %>)

new_receipt_total = <%= @receipt.total %>

$('#receipt-total').html "$" + new_receipt_total.toFixed(2)
