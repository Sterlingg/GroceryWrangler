$(document).bind 'page:change', ->
  $('#receipt_date_purchased').datepicker({format: "yyyy-mm-dd"})
