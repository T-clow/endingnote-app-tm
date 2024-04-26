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
          zoom: 18,
          center: userLocation
        });
  
        google.maps.event.addListenerOnce(map, 'tilesloaded', function() {
          document.getElementById('loading').style.display = 'none';
        });
  
        const marker = new google.maps.Marker({
          position: userLocation,
          map: map
        });
  
      }, function() {
        handleLocationError(true, map, map.getCenter());
      });
    } else {
      handleLocationError(false, map, map.getCenter());
    }
  }
  
  function handleLocationError(browserHasGeolocation, map, pos) {
    alert(browserHasGeolocation ?
      'エラー: 位置情報サービスに失敗しました。' :
      'エラー: お使いのブラウザでは位置情報サービスがサポートされていません。');
    map.setCenter(pos);
  }
  
  window.initMap = initMap;
  