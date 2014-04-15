module ReceiptItemsHelper

  def cancel_edit_button()
    class_string = "cancel-edit-item-btn hide btn btn-sm btn-danger glyphicon glyphicon-ban-circle"
    button_tag("", type: "button", class: class_string)
  end

  def edit_button()
    class_string = "edit-item-btn btn btn-primary btn-sm glyphicon glyphicon-edit"

    button_tag("", type: "button", class: class_string)
  end

  def delete_button(id)
    class_string = "delete-item-btn btn btn-sm btn-danger glyphicon glyphicon-remove pull-right"
    link_to("", 
            receipt_item_path(id), 
            class: class_string, 
            method: :delete, 
            remote: true)
  end

  def save_button()
    class_string = "save-item-btn hide btn btn-success btn-sm glyphicon glyphicon-floppy-disk"
    button_tag("", class: class_string)
  end
end
