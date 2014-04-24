$ ->
  path = location.pathname.match(
    /\/initiativen|\/vorlagen|\/baustellen/
  )
  path = path[0].slice 1 if path and path[0]
  return unless path

  iconMap =
    initiativen: { type: 'initiative', color: 'red'    }
    vorlagen:    { type: 'info',       color: 'blue'   }
    baustellen:  { type: 'baustelle',  color: 'orange' }

  icon        = L.AwesomeMarkers.icon
    icon: iconMap[path].type
    color: iconMap[path].color
  markersPath = '/markers'
  $form       = $('form[action="' + markersPath + '"]')
  $selects    = $form.find('select')
  $quarter    = $form.find('#quarter')
  params      = -> $form.serialize()

  $selects.change ->
    # Reset quarter when kommune changed
    $quarter.empty().val("").trigger "chosen:updated" if @id == 'kommune'

    $form.submit()

  $form.submit (event) ->
    event.preventDefault()
    $.getJSON(@action, params()).done (response) ->
      initiatives   = response.initiatives
      antraeges     = response.antraeges
      constructions = response.constructions
      location      = response.location
      zoom          = response.zoom
      refreshMarkers initiatives, antraeges, constructions
      map.panTo location
      map.setZoom zoom

  refreshMarkers = (initiatives, antraeges, constructions) ->
    map.removeLayer marker while marker = markers.pop()
    for collection in arguments
      for object in collection
        markers.push L.marker([object.lat, object.long], icon: icon).addTo(map).
          bindPopup object.popup

