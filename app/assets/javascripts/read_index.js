document.addEventListener('turbolinks:load',function(){
  $(document).on('mousemove', ".readed-lists__list__image a img", function(e){
    let divX = e.offsetX
    let divY = e.offsetY
    let centerX = $(this).width() * 0.5
    let centerY = $(this).height() * 0.5
    let mouseX = divX - ($(this).width() * 0.5)
    let mouseY = ($(this).height() * 0.5) - divY
    let angleX = mouseX / centerX * 20
    let angleY = mouseY / centerY * 20
    let imgPositionTop = 50
    let imgPositionLeft = 50
    let rotatePositionTop = imgPositionTop + angleY
    let rotatePositionLeft = imgPositionLeft - angleX / 2
    let rotateX = angleY + "deg"
    let rotateY = angleX + "deg"
    $(this).css("transform", "rotateX( "+ rotateX + ") " + "rotateY(" + rotateY + ")")
  })
  $(document).on('mouseout', ".readed-lists__list__image a img", function(e){
    $(this).css({transform: "rotateX(0) rotateY(0)"})
  })
})