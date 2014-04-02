# Update the quantity and price.
item_id = <%= @receipt_item.id %>
new_quantity = <%= @receipt_item.quantity %>
new_price =  <%= @receipt_item.price %>
old_quantity =  <%= @old_quantity %>
old_price = <%= @old_price %>
$("#item_quantity_#{item_id}").html(<%= @receipt_item.quantity %>)
$("#item_price_#{item_id}").html(<%= @receipt_item.price %>)

# Update the receipt total.
original_receipt_total = parseFloat $('#receipt-total').html().substring(1)

console.log (old_quantity - new_quantity) * new_price
new_receipt_total = original_receipt_total + (new_quantity - old_quantity) * new_price
console.log new_receipt_total
$('#receipt-total').html "$" + new_receipt_total.toFixed(2)
