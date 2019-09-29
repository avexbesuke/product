document.addEventListener('turbolinks:load',function(){
  $(function(){
    if($("#address").length){
      $(document).on('click', '.model-backgraund-intro, .map-initial', function() {
        $('.model-backgraund-intro').hide();
        $('.map-initial').hide();
      })

      $(".fa-question-circle").on("click",function(){
        $('.model-backgraund-intro-session').show();
        $('.map-initial-session').show();
      })

      $(document).on('click','.model-backgraund-intro-session, .map-initial-session',function() {
        $('.model-backgraund-intro-session').hide();
        $('.map-initial-session').hide();
      })
    }
  })
})