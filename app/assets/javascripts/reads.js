document.addEventListener('turbolinks:load',function(){
  $(function(){
    $(".book__image__link").on("ajax:success",function(e){
      let index = $('.book__image__link').index(this);
      if ($(".read-btn").eq(index).hasClass('read-btn-off')){
        $(".read-btn").eq(index).removeClass('read-btn-off').addClass('read-btn-on')
      } else{
        $(".read-btn").eq(index).removeClass('read-btn-on').addClass('read-btn-off')
      }
    })
  })
})