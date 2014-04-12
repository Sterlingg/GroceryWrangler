module ReceiptsHelper

  def add_item_button
    span = content_tag(:span, "", { :class => 'glyphicon glyphicon-plus'} )
    class_string = "btn btn-primary btn-lg btn-block"
    modal_id = '#selection-modal'

    link_to_opts ={
      remote: true, 
      "data-toggle" => 'modal', 
      "data-target" => modal_id, 
      class: class_string, 
      id: 'add-item-btn'
    }

    link_to(span + "Add Item", category_selection_dialog_path(receipt: @receipt), link_to_opts)
  end

  def delete_receipt_btn(id)
    span = content_tag(:span, 
                       "", 
                       class: "glyphicon glyphicon-remove")
    class_string = "edit-item-btn btn btn-danger btn-primary btn"
    link_to(span + " Delete", receipt_path(id), method: :delete, type: "button", class: class_string, confirm: 'Are you sure you want to delete this receipt?')
  end
end
