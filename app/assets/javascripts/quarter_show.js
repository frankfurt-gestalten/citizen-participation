$(document).ready(function () {
  if( $('#map.quarter-page').length == 0) {
    return;
  }

  var quarterCoords = $('#map').data('coords');
  var map = new L.Map('map').setView(new L.LatLng(quarterCoords[1], quarterCoords[0]), 15);
  var mapboxUrl = 'http://{s}.tiles.mapbox.com/v3/okf.map-najwtvl1/{z}/{x}/{y}.png',
  mapbox = new L.TileLayer(mapboxUrl, {"attribution": "\u00a9 <a href=\"http://www.openstreetmap.org/\" target=\"_blank\">OpenStreetMap</a> contributors"});
  map.addLayer(mapbox,true);
  map.scrollWheelZoom.disable();
  L.Icon.Default.imagePath = '/assets';

  var markers = new L.MarkerClusterGroup();
  map.addLayer(markers);

  var refreshMarkers = function (initiatives) {
    markers.clearLayers();

    for(var i = 0; i < initiatives.length; i++) {
      var initiative = initiatives[i];
      var initiativeIcon = L.AwesomeMarkers.icon({prefix: 'fa', icon: 'lightbulb-o', markerColor: 'red', iconColor: '#ffffff'});
      if( initiative.lat.length > 0 && initiative.long.length > 0 ) {
        var marker = new L.marker([initiative.lat, initiative.long], { icon: initiativeIcon });
        marker.bindPopup('<p><b>Initiative</b><br><a href="/initiativen/' + initiative.id + '">' + initiative.title + '</a></p>');
        markers.addLayer(marker);
      }
    }
    var antraeges = $('#map').data('antraeges');
      for(var i = 0; i < antraeges.length; i++) {
        var antraege = antraeges[i];
        var icon = L.AwesomeMarkers.icon({prefix: 'fa', icon: 'bullseye', markerColor: 'blue', iconColor: '#ffffff'});
        var marker = L.marker([antraege.lat, antraege.long], { icon: icon });
        marker.bindPopup('<p><b>Antrag Ortsbeirat</b> (' + $.datepicker.formatDate('dd.mm.yy', new Date(antraege.datum)) + '<br><a href="/vorlagen/' + antraege.id + '">' + antraege.title + '</a></p>');
        markers.addLayer(marker);
      }
    var constructions = $('#map').data('constructions');
    for(var i = 0; i < constructions.length; i++) {
      var construction = constructions[i];
      var icon = L.AwesomeMarkers.icon({prefix: 'fa', icon: 'warning', markerColor: 'green', iconColor: '#ffffff'});
      var marker = L.marker([construction.lat, construction.long], { icon: icon });
      marker.bindPopup('<p><b>Baustelle</b><br>' + $.datepicker.formatDate('dd.mm.yy', new Date(construction.start_date)) + '-' + $.datepicker.formatDate('dd.mm.yy', new Date(construction.end_date)) + '<br><a href="/baustellen/' + construction.id + '">' + construction.title + '<br>' + construction.description_long + '</a></p><p>Infos von <a href="http://www.mainziel.de" target="_blank">mainziel.de</a></p>');
      markers.addLayer(marker);
    }
  };

  refreshMarkers($('#map').data('initiatives'));

  $('#streets').change(function () {
    if( $(this).val().length ) {
      var location = $(this).val().split(',');
      map.setView(new L.LatLng(location[0], location[1]), 17);
    } else {
      map.setView(new L.LatLng(quarterCoords[1], quarterCoords[0]), 14);
    }
  });
});
