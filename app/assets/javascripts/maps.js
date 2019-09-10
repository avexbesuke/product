document.addEventListener('turbolinks:load',function(){
  function form_show(address,latitude,longitude){
    $('.model-backgraund').show();
    $('.map-form-wrapper').show();
    $('.map-form-wrapper__form').show();
    $('#map_address').val(address)
    $('#map_latitude').val(latitude)
    $('#map_longitude').val(longitude)
  }

  $(document).on('click', '.model-backgraund, .form-delete-btn', function() {
    $('.model-backgraund').hide();
    $('.map-form-wrapper').hide();
    $('.map-form-wrapper__form').hide();
  })

  $(document).ready(function(){
    function codeAddress(address){
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
                form_show(results[0].formatted_address,event.latLng.lat(),event.latLng.lng())
              } else{
                alert("住所の入力をお願いいたします")
              }
            })
          }
          google.maps.event.addListener(map,'click',myListener);
        } else{
          alert("住所の入力をお願いいたします");
        }
      })
    }

    $('.map-search-form').on('submit',function(e){
      e.preventDefault();
      var address = document.getElementById('address').value;
      $(".map-initial").remove();
      codeAddress(address);
    })

    $('.memori-search-form').on('submit',function(e){
      e.preventDefault();
      var address = $(this).children('#memori-address').val();
      $(".map-initial").remove();
      codeAddress(address);
      $(".memori-search-form__submit").removeAttr("disabled");
    })

    $(function initMap(){
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
          var geocoder = new google.maps.Geocoder();
          geocoder.geocode({location: event.latLng},function(results,status){
            if (status === 'OK' && results[0]){
              form_show(results[0].formatted_address,event.latLng.lat(),event.latLng.lng())
            } else{
              alert("住所の入力をお願いいたします")
            }
          })
        }
    
        google.maps.event.addListener(map,'click',myListener);
      })
    })
  });
})