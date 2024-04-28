document.addEventListener("turbo:render", function() {
    if (document.getElementById("map")) {
      initMap();
    }
  });
  
  function initMap() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        const userLocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
  
        const map = new google.maps.Map(document.getElementById('map'), {
          zoom: 12.5,
          center: userLocation
        });
  
        const avatarUrl = document.getElementById('user-avatar').getAttribute('data-avatar-url');
  
        const userMarker = new google.maps.Marker({
          position: userLocation,
          map: map,
          icon: {
            url: avatarUrl,
            scaledSize: new google.maps.Size(40, 40)
          }
        });
  
        const service = new google.maps.places.PlacesService(map);
        const request = {
          location: userLocation,
          radius: '10000',
          type: ['funeral_home']
        };
  
        service.nearbySearch(request, function(results, status) {
          if (status === google.maps.places.PlacesServiceStatus.OK) {
            results.forEach(function(place) {
              createMarker(place, map);
            });
          }
        });
  
      }, function(error) {
        handleLocationError(true, map, map.getCenter());
      });
    } else {
      handleLocationError(false, null, map.getCenter());
    }
  }
  
  function createMarker(place, map) {
    const iconUrl = document.getElementById('funeral-home-icon').getAttribute('data-icon-url');
    
    const placeMarker = new google.maps.Marker({
      position: place.geometry.location,
      map: map,
      icon: {
        url: iconUrl,
        scaledSize: new google.maps.Size(30, 30)
      }
    });
  }
  
  function handleLocationError(browserHasGeolocation, map, pos) {
    alert(browserHasGeolocation ?
      'エラー: 位置情報サービスに失敗しました。' :
      'エラー: お使いのブラウザでは位置情報サービスがサポートされていません。');
    if (map) {
      map.setCenter(pos);
    }
  }
  
  window.initMap = initMap;
  