cols_to_replace = 
  quantity: 
    index: 4
    type: 'text'
    class: 'form-control'
  price: 
    index: 7
    type: 'text'
    class: 'form-control'

get_buttons = (button_context) ->
  button_group = button_context.parent()
  row: $(button_context.parent().parent().parent().children())
  cancel: $('.cancel-edit-item-btn', button_group)
  edit: $('.edit-item-btn', button_group)
  save: $('.save-item-btn', button_group)

hide_save_btn_group = (buttons) ->
  buttons['cancel'].addClass "hide"
  buttons['save'].addClass "hide"
  buttons['edit'].removeClass "hide"

show_save_btn_group = (buttons) ->
  buttons['save'].removeClass "hide"
  buttons['cancel'].removeClass "hide"
  buttons['edit'].addClass "hide"

# Creates a new input box with the width of the
# element previously contained in this column.
create_input = (old_elem, info) ->
    new_elem = $(document.createElement('input'))
    new_elem.attr('name', info['type'])
    new_elem.addClass(info['class'])
      
    new_elem.attr('data-editing', true)

    new_elem.width(old_elem.width())
    new_elem.addClass('hide')

    new_elem

cancel_btn_handler = ->
  buttons = get_buttons $(this)
          
  for name, values of cols_to_replace
    td = $(buttons['row'][values['index']])
  
    $('input', td).addClass "hide"
    $('span', td).removeClass "hide"

  hide_save_btn_group(buttons)

edit_btn_handler = ->
  buttons = get_buttons $(this)
  for name, values of cols_to_replace
    td = $(buttons['row'][values['index']])
  
    $('span', td).addClass "hide"
    $('input', td).removeClass "hide"

  show_save_btn_group(buttons)

save_btn_handler = ->
  buttons = get_buttons $(this)

  hide_save_btn_group(buttons)

  for name, values of cols_to_replace
    td = $(buttons['row'][values['index']])

    $('span', td).removeClass "hide"
    $('input', td).addClass "hide"

  # Get the fields from the table to submit.
  tr = $(buttons['row'][0]).parent()
  table_id = $('.item-table-id', tr)
  table_quantity = $('.item-table-quantity', tr)
  table_price = $('.item-table-price', tr)

  # Fill in the hidden field with these values.
  $('#item-id').val(table_id.val())
  $('#item-quantity').val(table_quantity.val())
  $('#item-price').val(table_price.val())

  form = $('#item-id').parent()
  
  form.submit()
        
  $('.edit-item-btn').bind 'click', edit_btn_handler

$(document).bind 'page:change', ->

  $('.cancel-edit-item-btn').bind 'click', cancel_btn_handler
  $('.edit-item-btn').bind 'click', edit_btn_handler
  $('.save-item-btn').bind 'click', save_btn_handler
    # Calculate the total for the receipt.
  receipt_total = 0.0
  $('#receipt-item-table>tbody>tr').each ->
    price =  parseFloat($('.item-table-price-text', $(this)).html())
    quantity =  parseFloat($('.item-table-quantity-text', $(this)).html())
    receipt_total += price * quantity
  
  # Update the receipt total.
  $('#receipt-total').html "$" + receipt_total.toFixed(2)
