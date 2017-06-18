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

$(document).on("click", ".rooms-nav-link", function(e){
    $('#rooms-span').attr('class', $(this).text());
});

$(document).on("click", "#add-button-row", function(e){
    $('#smallModalLabel').html($('#rooms-span').attr('class'));
    $('#hidden-room-name').val($('#smallModalLabel').text());
});

$(document).on("click", ".nav-pills > li > a", function(e){
    $('li.active').removeClass("active");
    $(this).parent().addClass("active");
});



