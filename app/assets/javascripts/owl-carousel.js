document.addEventListener('turbolinks:load',function(){
  $(document).ready(function(){
    if ($(".emotions-index-wrapper__head__search_tags").length){
      $('.owl-carousel').owlCarousel({
        autoWidth:true,
        loop:true,
        margin:5,
        dots: false,
        autoplay: true,
        autoplayTimeout: 2000,
        autoplayHoverPause: true,
        responsive:false,
        mergeFit:true
      });
    }
    if ($(".map-index-wrapper__map__search")){
      $('.owl-carousel').owlCarousel({
        margin:5,
      }); 
    }
  });
})