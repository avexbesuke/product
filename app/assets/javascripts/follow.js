document.addEventListener('turbolinks:load',function(){
  function follow(triger,target,onclass,offclass){
    triger.on("ajax:success",function(e){
      let index = triger.index(this);
      if (target.eq(index).hasClass(offclass)){
        target.eq(index).removeClass(offclass).addClass(onclass)
      } else{
        target.eq(index).removeClass(onclass).addClass(offclass)
      }
    })
  }

  follow($(".book__image__link"),$(".read-btn"),'read-btn-on','read-btn-off')

  follow($(".emotion__follow__link"),$(".follow-btn"),'follow-btn-on','follow-btn-off')
})