var toggleSpinner = function(){
  $('#spinner').toggle();
}

var initStockLookup = function() {
  $('#stock-lookup-form').on('ajax:before', function(event, data, status) {
    toggleSpinner();
  });

  $('#stock-lookup-form').on('ajax:after', function(event, data, status) {
    toggleSpinner();
  });

  $('#stock-lookup-form').on('ajax:success', function(event, data, status) {
    $('#stock-lookup').replaceWith(data);
    initStockLookup();
  });

  $('#stock-lookup-form').on('ajax:error', function(event, xhr, status, error) {
    toggleSpinner();
    $('#stock-lookup-results').replaceWith(' ');
    $('#stock-lookup-errors').replaceWith('Stock was not found.');
  });

  $('#update-stocks-button').on('ajax:before', function(event, data, status) {
    $('#big-spinner').show();
    $('#stock-portfolio').hide()
  });

  $('#update-stocks-button').on('ajax:success', function(event, data, status) {
    $('#big-spinner').toggle();
    $('#stock-portfolio').replaceWith(data);
    $('#last-updated em').replaceWith('<em>' + Date(event.timeStamp) + '</em>')
    initStockLookup();
  });
}

$(document).ready(function() {
  initStockLookup();
})
