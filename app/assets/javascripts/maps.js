document.addEventListener('turbolinks:load',function(){
  function form_show(address,latitude,longitude){
    $('.haikei').show();
    $('.fooorm').show();
    $('.fooormcon').show();
    $('#map_address').val(address)
    $('#map_latitude').val(latitude)
    $('#map_longitude').val(longitude)
  }

  function codeAddress(){
    var address = document.getElementById('address').value;
    var geocoder = new google.maps.Geocoder();
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 17,
      mapTypeId: google.maps.MapTypeId.HYBRID
    });
    geocoder.geocode({address: address},function(results,status){
      if (status == google.maps.GeocoderStatus.OK){
        map.setCenter(results[0].geometry.location);

        function myListener(event){
          var marker = new google.maps.Marker();
          marker.setPosition(new google.maps.LatLng(event.latLng.lat(),event.latLng.lng()));
          marker.setMap(map);
          var geocoder = new google.maps.Geocoder();
          geocoder.geocode({location: event.latLng},function(results,status){
            if (status === 'OK' && results[0]){
              console.log(results[0].formatted_address)
              form_show(results[0].formatted_address,event.latLng.lat(),event.latLng.lng())
            } else{
              alert('処理失敗:' + status)
            }
          })
        }




        google.maps.event.addListener(map,'click',myListener);
      } else{
        alert('処理失敗:' + status);
      }
    })
  }

  $('.map_form').on('submit',function(e){
    e.preventDefault();
    codeAddress();
  })

  $(function(){
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 17,
      mapTypeId: google.maps.MapTypeId.HYBRID,
      center: {lat: 35.038037, lng: 135.772773},
    });

    function myListener(event){
      var marker = new google.maps.Marker();
      marker.setPosition(new google.maps.LatLng(event.latLng.lat(),event.latLng.lng()));
      marker.setMap(map);
      console.log(event.latLng.lat())
      console.log(event.latLng.lng())
      //reverse geocoder
      var geocoder = new google.maps.Geocoder();
      geocoder.geocode({location: event.latLng},function(results,status){
        if (status === 'OK' && results[0]){
          console.log(results[0].formatted_address)
          form_show(results[0].formatted_address,event.latLng.lat(),event.latLng.lng())
        } else{
          alert('処理失敗:' + status)
        }
      })
    }

    google.maps.event.addListener(map,'click',myListener);
  })

  $(document).on('click', '.haikei, .fomdele', function() {
    $('.haikei').hide();
    $('.fooorm').hide();
    $('.fooormcon').hide();
})
})