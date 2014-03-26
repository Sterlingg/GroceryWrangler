$('#selection-modal').modal('hide')
table_rows = "<%= j(render partial: 'shared/item_table_entry', locals: { receipt_items: @new_receipt_items}) %>"
$('#receipts-table>tbody').append(table_rows)
