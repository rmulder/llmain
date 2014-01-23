$(function() {
    $('.more-lists-link').click( function() {
    $('.large-list-wrap-multi')
            .animate({opacity:'toggle',
                      height:'toggle'},'slow');

    $('.large-list-wrap-single')
            .animate({opacity:'toggle',
                      height:'toggle'},'slow');
        return false;
    });
});