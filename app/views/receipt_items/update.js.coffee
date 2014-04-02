# Update the quantity and price.
item_id = <%= @receipt_item.id %>

$("#item_quantity_#{item_id}").html(<%= @receipt_item.quantity %>)
$("#item_price_#{item_id}").html(<%= @receipt_item.price %>)

