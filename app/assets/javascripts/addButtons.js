$( document ).ready(function() {
    $('.add-buttons').click(function(){
        var room = $(this).parent().children('a').text();
        $( '#smallModalLabel' ).html( room );
    });
});