

alert <- function(..., status = "success") {
  tags$div(
    class=paste0("alert alert-", status),
    ...
  )
}

toggleInputUi <- function() {
  tags$script(
    "Shiny.addCustomMessageHandler('toggleInput',
    function(data) {
    $('#' + data.id).prop('disabled', !data.enable);
    if (!data.enable) {
      $('#' + data.id).addClass('disabled');
    } else {
      $('#' + data.id).removeClass('disabled');
    }
    if (data.picker) {
    $('#' + data.id).selectpicker('refresh');
    }
    }
  );"
  )
}

toggleInputServer <- function(session, inputId, enable = TRUE, picker = FALSE) {
  session$sendCustomMessage(
    type = 'toggleInput',
    message = list(id = inputId, enable = enable, picker = picker)
  )
}
