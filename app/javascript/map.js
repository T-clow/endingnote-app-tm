document.addEventListener("turbo:render", function() {
  if (document.getElementById("map")) {
    window.initMap();
  }
});

window.initMap = function(lat = null, lng = null) {
  if (!lat || !lng && navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      showMap(position.coords.latitude, position.coords.longitude);
    }, function() {
      handleLocationError(true, null, {lat: 0, lng: 0});
    });
  } else if (lat && lng) {
    showMap(lat, lng);
  } else {
    handleLocationError(false, null, {lat: 0, lng: 0});
  }
}

function showMap(lat, lng) {
  const userLocation = { lat: lat, lng: lng };
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

  google.maps.event.addListener(placeMarker, 'click', () => {
    const placeId = place.place_id;
    const url = `https://www.google.com/maps/search/?api=1&query=Google&query_place_id=${placeId}`;
    window.open(url, '_blank');
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

window.geocodeAddress = function() {
  const address = document.getElementById('address-input').value;
  const geocoder = new google.maps.Geocoder();

  geocoder.geocode({ 'address': address }, function(results, status) {
    if (status === 'OK') {
      window.initMap(results[0].geometry.location.lat(), results[0].geometry.location.lng());
    } else {
      alert('検索した住所を見つけられませんでした');
    }
  });
}
