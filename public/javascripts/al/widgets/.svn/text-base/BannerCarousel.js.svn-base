function mycarousel_initCallback(carousel) {
    jQuery('.jcarousel-control a').bind('click', function() {
        carousel.scroll(jQuery.jcarousel.intval(jQuery(this).attr('id')));
        return false;
    });

};


jQuery(document).ready(function() {
    jQuery('#marketing-banner-carousel').jcarousel({
        scroll: 1,
        initCallback: mycarousel_initCallback,
        // This tells jCarousel NOT to autobuild prev/next buttons
        buttonNextHTML: null,
        buttonPrevHTML: null
        
    });

    jQuery('ul li.opaque').hover(function(){
       jQuery(this).children('a').animate({opacity:1,color:'#000'},'medium');
       jQuery(this).children('p').animate({opacity:1,color:'rgb(0,0,255)'},'medium');
       jQuery(this).closest('li').animate({bgColor:'rgba(190,190,190,0.8)'},'medium');
    },
                                 function(){
       jQuery(this).children('a').animate({opacity:.6,color:'rgb(0,0,0)'},'medium');
       jQuery(this).children('p').animate({opacity:.6,color:'rgb(20,20,250)'},'medium');
       jQuery(this).closest('li').animate({bgColor:'rgba(230,230,230,0.6)'},'medium');
    });

});
