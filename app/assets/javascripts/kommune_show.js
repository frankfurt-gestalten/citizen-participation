$(document).ready(function () {
  if( $('#map.kommune-page').length == 0) {
    return;
  }

  var kommuneCoords = $('#map').data('coords');
  var map = new L.Map('map').setView(new L.LatLng(kommuneCoords[0], kommuneCoords[1]), 14);
  var mapboxUrl = 'http://{s}.tiles.mapbox.com/v3/okf.map-najwtvl1/{z}/{x}/{y}.png',
  mapbox = new L.TileLayer(mapboxUrl, {"attribution": "\u00a9 <a href=\"http://www.openstreetmap.org/\" target=\"_blank\">OpenStreetMap</a> contributors"});
  map.addLayer(mapbox,true);
  map.scrollWheelZoom.disable();
  L.Icon.Default.imagePath = '/assets';

  var markers = new L.LayerGroup();
  map.addLayer(markers);

  var refreshMarkers = function (initiatives) {
    markers.clearLayers();

    for(var i = 0; i < initiatives.length; i++) {
      var initiative = initiatives[i];
      var initiativeIcon = L.AwesomeMarkers.icon({icon: 'initiative', color: 'red'});
      if( initiative.lat.length > 0 && initiative.long.length > 0 ) {
        var marker = new L.marker([initiative.lat, initiative.long], { icon: initiativeIcon });
        marker.bindPopup($('.marker-popup[data-id="' + initiative.id + '"]').html());
        markers.addLayer(marker);
      }
    }
    var antraeges = $('#map').data('antraeges');
      for(var i = 0; i < antraeges.length; i++) {
        var antraege = antraeges[i];
        var icon = L.AwesomeMarkers.icon({icon: 'info', color: 'blue'});
        var marker = L.marker([antraege.lat, antraege.long], { icon: icon });
        marker.bindPopup('<a href="/vorlagen/' + antraege.id + '">' + antraege.title + '<br>Zur Rats-Info</a>');
        markers.addLayer(marker);
      }
    var constructions = $('#map').data('constructions');
      for(var i = 0; i < constructions.length; i++) {
        var construction = constructions[i];
        var icon = L.AwesomeMarkers.icon({icon: 'baustelle', color: 'orange'});
        var marker = L.marker([construction.lat, construction.long], { icon: icon });
        marker.bindPopup('<a href="/baustellen/' + construction.id + '">' + construction.title + '<br>' + $.datepicker.formatDate('dd.mm.yy', new Date(construction.start_date)) + ' - ' + $.datepicker.formatDate('dd.mm.yy', new Date(construction.end_date)) + '<br>Zur Baustelle</a>');
        markers.addLayer(marker);
      }
  };

  refreshMarkers($('#map').data('initiatives'));

  $('#quarters').change(function () {
    if( $(this).val().length ) {
      var location = $(this).val().split(',');
      map.setView(new L.LatLng(location[1], location[0]), 16);
    } else {
      map.setView(new L.LatLng(kommuneCoords[0], kommuneCoords[1]), 14);
    }
  });
});
