// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require addButtons
//= require_tree .

$(document).on("click", ".rooms-nav-link", function(){
    $('#rooms-span').attr('class', $(this).text());
});

$(document).on("click", "#add-button-row", function(){
    $('#smallModalLabel').html($('#rooms-span').attr('class'));
    $('#smallModal #hidden-room-name').val($('#smallModalLabel').text());
});

$(document).on("click", ".nav-pills > li > a", function(){
    $('.nav-pills > li.active').removeClass("active");
    $(this).parent().addClass("active");
});

$(document).on("click", "#appliance", function(e){
    $('#editModal form').attr('action', function(i, value) {
        return value + "/1";
    });
})

$(document).on("click", ".update-appliance-button", function(e){
    var element = e.target.closest('.col-md-3');
    var countObject = $(element).prev();
    var performanceObject = $(countObject).prev();
    var applianceObject = $(performanceObject).prev();
    var roomObject = $('.nav-pills > li.active');
    //$('#text').html(name);
    $('#editModal #room').val($.trim(roomObject.text()));
    $('#editModal #name').val($.trim(applianceObject.text()));
    $('#editModal #performance').val(parseInt(performanceObject.text()));
    $('#editModal #count').val(parseInt(countObject.text()));
    var appliance_id = $(this).data('appliance-id');
    $('form').attr('action', function(i, value) {
        value = value.substr(0, value.lastIndexOf("/"));
        return value + "/" + appliance_id;
    });
    $('#hidden-entry-id').val($(this).data('entry-id'));
    $('#hidden-room-id').val($(this).data('room-id'));
    $('#editModal #hidden-room-name').val($.trim(roomObject.text()));
});


