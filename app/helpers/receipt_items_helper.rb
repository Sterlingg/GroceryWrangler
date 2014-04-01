module ReceiptItemsHelper
  def edit_button()
    class_string = "btn btn-primary btn-sm edit-item-btn glyphicon glyphicon-edit"

    content_tag(:button, "", {:class => class_string, :'data-editing' => false} )
  end

  def cancel_edit_button()
    class_string = "hide btn btn-primary btn-sm btn-danger cancel-edit-item-btn glyphicon glyphicon-ban-circle"
    content_tag(:button, "", {:class => class_string} )
  end

  def save_button()
    class_string = "hide btn btn-primary btn-sm save-item-btn glyphicon glyphicon-floppy-disk"
    content_tag(:button, "", {:class => class_string} )
  end
end
