var toggleSpinner = function(){
  $('#spinner').toggle();
}

var initFriendLookup = function() {
  $('#friend-lookup-form').on('ajax:before', function(event, data, status) {
    toggleSpinner();
  });

  $('#friend-lookup-form').on('ajax:after', function(event, data, status) {
    toggleSpinner();
  });

  $('#friend-lookup-form').on('ajax:success', function(event, data, status) {
    $('#friend-lookup').replaceWith(data);
    initFriendLookup();
  });

  $('#friend-lookup-form').on('ajax:error', function(event, xhr, status, error) {
    toggleSpinner();
    $('#friend-lookup-results').replaceWith(' ');
    $('#friend-lookup-errors').replaceWith('Friend was not found.');
  });
}

$(document).ready(function() {
  initFriendLookup();
})
