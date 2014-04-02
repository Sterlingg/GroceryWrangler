module ReceiptItemsHelper
  def edit_button()
    class_string = "btn btn-primary btn-sm edit-item-btn glyphicon glyphicon-edit"

    button_tag("", type: "button", class: class_string)
  end

  def cancel_edit_button()
    class_string = "hide btn btn-primary btn-sm btn-danger cancel-edit-item-btn glyphicon glyphicon-ban-circle"
    button_tag("", type: "button", class: class_string)
  end

  def save_button()
    class_string = "hide btn btn-primary btn-sm save-item-btn glyphicon glyphicon-floppy-disk"
    button_tag("", class: class_string)
  end
end
