$(document).ready(function () {
  $('.pages_quarters_front').change(function () {
      window.location = '/stadtteil/' + $('.pages_quarters_front').val();
  })
  if( $('#map.start-page').length == 0) {
    return;
  }

  var map = new L.Map('map').setView(new L.LatLng(50.119182 , 8.677139), 12);
  var mapboxUrl = 'http://{s}.tiles.mapbox.com/v3/okf.map-najwtvl1/{z}/{x}/{y}.png',
  mapbox = new L.TileLayer(mapboxUrl, {"attribution": "\u00a9 <a href=\"http://www.openstreetmap.org/\" target=\"_blank\">OpenStreetMap</a> contributors"});
  map.addLayer(mapbox,true);
  map.scrollWheelZoom.disable();

  // var minimap = new L.Map('minimap',{ zoomControl:false, attributionControl: false }).setView(new L.LatLng(50.709047 , 6.180028), 9);
  // minimapbox = new L.TileLayer(mapboxUrl);
  // minimap.addLayer(minimapbox,true);
  // minimap.scrollWheelZoom.disable();
  // minimap.doubleClickZoom.disable();
  // minimap.dragging.disable();

  // for(var i = 0; i < polygon.length; i ++) {
  //   var currentPolygon = L.polygon(polygon[i], { stroke: false});
  //   currentPolygon.addTo(minimap);
  // }

  // var minimapRectangle = L.rectangle(map.getBounds(), {color: '#ff7800', weight: 1}).addTo(minimap);

  // var updateMinimap = function () {
  //   minimapRectangle.setBounds(map.getBounds());
  // };
  // map.addEventListener('move', updateMinimap);

  var markers = new L.MarkerClusterGroup();
  map.addLayer(markers);

  var refreshMarkers = function (initiatives) {
    markers.clearLayers();

    for(var i = 0; i < initiatives.length; i++) {
      var initiative = initiatives[i];
      if( initiative.lat.length > 0 && initiative.long.length > 0 ) {
        var initiativeIcon = L.AwesomeMarkers.icon({prefix: 'fa', icon: 'lightbulb-o', markerColor: 'red', iconColor: '#ffffff'});
        var marker = new L.marker([initiative.lat, initiative.long], { icon: initiativeIcon });
        marker.bindPopup('<p><b>Initiative</b><br><a href="/initiativen/' + initiative.id + '">' + initiative.title + '</a></p>');
        markers.addLayer(marker);
      }
    }

    var antraeges = $('#map').data('antraeges');
    for(var i = 0; i < antraeges.length; i++) {
      var antraege = antraeges[i];
      var icon = L.AwesomeMarkers.icon({prefix: 'fa', icon: 'file-text', markerColor: 'blue', iconColor: '#ffffff'});
      var marker = L.marker([antraege.lat, antraege.long], { icon: icon });
      marker.bindPopup('<p><b>Antrag Ortsbeirat</b><br><a href="/vorlagen/' + antraege.id + '">' + antraege.title + '</a></p>');
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

  var kommunen = $('div[data-kommunen]').data('kommunen');
  var quartersData = $('*[data-quarters]').data('quarters');

  var zoomToKommune = function () {
    var kommune = null;
    var selected = parseInt($('#kommunen').val());
    for(var i = 0; i < kommunen.length; i++) {
      if( kommunen[i].id == selected ) {
        kommune = kommunen[i];
        break;
      }
    }

    if( kommune ) {
      $('#seitenverweis').html('  Mehr Infos zu <a href="' + '/stadtteil/' + kommune.id + '">' + kommune.name + '</a>')
      map.setView(new L.LatLng(kommune.latitude, kommune.longitude), 13);
    }
    else {
      map.setView(new L.LatLng(50.759047 , 6.130028), 11);
    }
  };

  var zoomToQuarter = function () {
    var data = quartersData[$('#quarters').val()];
    var selected = $('#quarters').find(':selected');
    $('#seitenverweis').html('Mehr Infos zu <a href="' + '/stadtteil/' + selected.attr('value') + '">' + selected.text() + '</a>')
    var location = data.coords;
    map.setView(new L.LatLng(location[1], location[0]), 14);
  };

  updateStreets = function () {
    var name = $('#quarters').find('option:selected').text();
    $('#streets').empty();
    $('#streets').val('');
    if( !name || !name.length ) {
      $('#streets').trigger('chosen:updated');
    }
    else {
      $.get('/stadtteil/' + name + '/streets', function (data) {
        for(var i = 0; i < data.length; i++) {
          $('#streets').append('<option value="' + [data[i].latitude, data[i].longitude].join(',') +
            '">' + data[i].name + '</option>');
        }
        $('#streets').val('').trigger('chosen:updated');
      });
    }
  };

  $('#quarters').change(function () {
    if( $(this).val().length ) {
      zoomToQuarter();

      $('#spinner').show()
      $.get('/stadtteil/' + $(this).val() + '/initiatives', function(data) {
        refreshMarkers(data);
        $('#spinner').hide()
      });

      updateStreets();
    }
    else {
      zoomToKommune();
      $('#streets').empty().val('').trigger('chosen:updated');
    }
  });

  $('#streets').change(function () {
    if( $(this).val().length ) {
      var location = $(this).val().split(',');
      map.setView(new L.LatLng(location[0], location[1]), 16);
    }
    else {
      zoomToQuarter();
      $('#streets').empty().val('').trigger('chosen:updated');
    }
  });
});