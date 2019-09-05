document.addEventListener('turbolinks:load',function(){
  $(function(){
    $(".accordion-icon").on("click", function() {
      $(this).next().slideToggle();
    })
  });
})