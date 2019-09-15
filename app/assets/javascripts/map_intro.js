document.addEventListener('turbolinks:load',function(){
  $(function(){
    if($("#address").length){
      $(document).on('click', '.model-backgraund-intro, .map-initial', function() {
        $('.model-backgraund-intro').hide();
        $('.map-initial').hide();
      })
    }
  })
})