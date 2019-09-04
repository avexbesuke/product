document.addEventListener('turbolinks:load',function(){
  $(function(){
    $('.tab_b').hide();
    $('.tab1').show();
    $('.tab_a').click(function(){
      $('.tab_b').hide();
      let a = $(this).attr("class").split(" ")[0]
      $(`.${a}`).show();
      $('.current').removeClass('current')
      $(this).addClass('current')
      return false
    })
  })
})