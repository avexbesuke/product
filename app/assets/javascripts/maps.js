document.addEventListener('turbolinks:load',function(){
  $(document).ready(function() { 
    initMap()
  })
  function initMap(){
    let map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
    });
  }
})