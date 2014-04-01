get_buttons = (button_context) ->
  button_group = button_context.parent()
  row: $(button_context.parent().parent().parent().children())
  cancel: $('.cancel-edit-item-btn', button_group)
  edit: $('.edit-item-btn', button_group)
  save: $('.save-item-btn', button_group)

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

$(document).ready ->
    cols_to_replace = 
      name: 
        index: 1
        type: 'text'
        class: 'form-control'
      quantity: 
        index: 3
        type: 'text'
        class: 'form-control'
      price: 
        index: 6
        type: 'text'
        class: 'form-control'

    $('.edit-item-btn').each (btn) ->
      buttons = get_buttons $(this)

      for name, values of cols_to_replace
        console.log($(buttons['row'])[0])
        td = $(buttons['row'][values['index']])

        new_input_box = create_input(td, cols_to_replace)

        td.append(new_input_box)
        
    $('.cancel-edit-item-btn').bind 'click',
        ->
          buttons = get_buttons $(this)
          
          for name, values of cols_to_replace
            td = $(buttons['row'][values['index']])
  
            $('input', td).addClass "hide"
            $('span', td).removeClass "hide"

          buttons['cancel'].addClass("hide");

          buttons['save'].addClass("hide");
          buttons['edit'].removeClass("hide");
          
    $('.save-item-btn').bind 'click',
      ->
        buttons = get_buttons $(this)

        buttons['cancel'].addClass "hide"
        buttons['save'].addClass "hide"
        buttons['edit'].removeClass "hide"

        for name, values of cols_to_replace
          td = $(buttons['row'][values['index']])

          $('span', td).removeClass "hide"
          $('input', td).addClass "hide"

    
    $('.edit-item-btn').bind 'click',
        ->
          buttons = get_buttons $(this)
          for name, values of cols_to_replace
            td = $(buttons['row'][values['index']])

            $('span', td).addClass "hide"
            $('input', td).removeClass "hide"

          # Show the cancel button and remove the edit button.
          # To be replaced by the save item button.
          buttons['save'].removeClass "hide"
          buttons['cancel'].removeClass "hide"
          buttons['edit'].addClass "hide"
