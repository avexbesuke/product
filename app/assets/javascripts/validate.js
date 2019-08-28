document.addEventListener('turbolinks:load',function(){
  $('.alert').hide()

  function form_validate(target,alert){
    if(!target){
      alert.show();
      sendflag = false
    }else{
      alert.hide();
    }
  }
  
  function form_validate_variable(){
    let target_pass     = $('.user-pass').val()
    let target_passcon  = $('.user-passcon').val()
    let target_email    = $('.user-email').val()
    let target_username = $('.user-username').val()
  
    let alert_pass      = $('.new_user__pass .alert')
    let alert_passcon   = $('.new_user__passcon .alert')
    let alert_email     = $('.new_user__email .alert')
    let alert_username  = $('.new_user__username .alert')
  }

  $('.btn-login').click(function(){
    form_validate($('.user-pass').val(),$('.new_user__pass .alert'))
    form_validate($('.user-email').val(),$('.new_user__email .alert'))
    if(sendflag == false){
      return false
    }
  })

  $('.btn-signup').click(function(){
    let target_pass     = $('.user-pass').val()
    let target_passcon  = $('.user-passcon').val()
    let target_email    = $('.user-email').val()
    let target_username = $('.user-username').val()
  
    let alert_pass      = $('.new_user__pass .alert')
    let alert_passcon   = $('.new_user__passcon .alert')
    let alert_email     = $('.new_user__email .alert')
    let alert_username  = $('.new_user__username .alert')
    form_validate(target_pass,alert_pass)
    form_validate(target_passcon,alert_passcon)
    form_validate(target_email,alert_email)
    form_validate(target_username,alert_username)
    if(sendflag == false){
      return false
    }
  })
});