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

  $(".map-create-form").submit(function(e){
    if ($("#map_memori").val() == ""){
      e.preventDefault()
      window.alert("思い出を入力願います")
    }
  })
  $("#map_memori").on('click',function(){
    $(".map-create-form__submit").removeAttr('disabled');
  })
})