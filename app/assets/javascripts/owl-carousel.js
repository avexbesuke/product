document.addEventListener('turbolinks:load',function(){
$(document).ready(function(){
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
  });
})