$(document).bind 'page:change', ->
  mainScreenHeight = $(document).height() - (parseInt($('.container-fluid').height()) + parseInt($('.navbar').css("margin-bottom")))

  $('.receipts-container').css("height", (mainScreenHeight - 10) + "px")
