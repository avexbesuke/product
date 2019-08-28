document.addEventListener('turbolinks:load',function(){
  $('.alert').hide()
  $('.btn-login').click(function(){
    let pass = $('.user-pass').val()
    let email = $('.user-email').val()
    let sendflag = true
    if(!pass ){
      $('.new_user__pass .alert').show();
      sendflag = false
    }else{
      $('.new_user__pass.alert').hide();
    }
    if(!email){
      $('.new_user__email .alert').show();
      sendflag = false
    }else{
      $('.new_user__email .alert').hide();
    }
    if(sendflag == false){
      return false
    }
  })
});