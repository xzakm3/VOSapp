# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "click", ".update-appliance-button", (e)->
  element = e.target.closest('.col-md-3')
  countObject = $(element).prev()
  performanceObject = $(countObject).prev();
  applianceObject = $(performanceObject).prev();
  roomObject = $('.nav-pills > li.active');
  $('#text').html(name);
  $('#editModal #room').val($.trim(roomObject.text()));
  $('#editModal #name').val($.trim(applianceObject.text()));
  $('#editModal #performance').val(parseInt(performanceObject.text()));
  $('#editModal #count').val(parseInt(countObject.text()));
  appliance_id = $(this).data('appliance-id');
  $('form').attr 'action', (i, value)->
    value = value.substr(0, value.lastIndexOf("/"));
    return value + "/" + appliance_id;
  $('#hidden-entry-id').val($(this).data('entry-id'));
  $('#hidden-room-id').val($(this).data('room-id'));
  $('#editModal #hidden-room-name').val($.trim(roomObject.text()));


$(document).on "click", ".rooms-nav-link", ->
  $('#rooms-span').attr('class', $(this).text());


$(document).on "click", "#add-button-row", ->
  $('#smallModalLabel').html($('#rooms-span').attr('class'));
  $('#smallModal #hidden-room-name').val($('#smallModalLabel').text());

$(document).on "click", ".nav-pills > li > a", ->
  $('.nav-pills > li.active').removeClass("active");
  $(this).parent().addClass("active");


$(document).on "click", "#appliance", (e)->
  $('#editModal form').attr 'action', (i, value)->
    return value + "/1";


$(document).on "change", "#bigModal input#room", ->
  $('#bigModal #bigModalLabel').text $(this).val();