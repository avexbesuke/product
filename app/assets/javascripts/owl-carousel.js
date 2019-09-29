document.addEventListener('turbolinks:load',function(){
$(document).ready(function(){
    $('.owl-carousel').owlCarousel({
      // items:10,
      autoWidth:true,
      loop:true,
      margin:5,
      // merge:true,
      dots: false,
      autoplay: true,
      autoplayTimeout: 2000,
      autoplayHoverPause: true,
      // nav:true,
      responsive:false,
      mergeFit:true
    });
  });
})