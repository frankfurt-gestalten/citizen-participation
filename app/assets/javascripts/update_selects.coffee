$ ->
  path = location.pathname.match(
    /\/initiativen|\/vorlagen|\/baustellen/
  )
  path = path[0].slice 1 if path and path[0]
  return unless path

  $kommune = $('#kommune')
  $quarter = $('#quarter')
  $street  = $('#street')
  $spinner = $('#spinner')
  $form    = $kommune.parents('form')

  kommunen = $('div[data-kommunen]').data('kommunen')
  quartersData = $('*[data-quarters]').data('quarters')

  $kommune.change ->
    if $(this).val().length is 0
      map.setView new L.LatLng(50.775346, 6.083887), 13
      $quarter.empty().val("").trigger "chosen:updated"
      $street.empty().val("").trigger "chosen:updated"
      true

    $.get "/kommunen/" + $(this).val() + "/quartiere", (data) ->
      $quarter.empty()
      $quarter.val ""
      $spinner.hide()
      i = 0

      while i < data.length
        $quarter.append "<option value=\"" + data[i].id + "\">" +
          data[i].name + "</option>"
        i++
      $quarter.val("").trigger "chosen:updated"
      updateStreets()
      return

  updateStreets = ->
    name = $quarter.find("option:selected").text()
    $street.empty()
    $street.val ""
    if not name or not name.length
      $street.trigger "chosen:updated"
    else
      $.get "/quartier/" + encodeURIComponent(name) + "/streets", (data) ->
        i = 0

        while i < data.length
          $street.append "<option value=\"" + [
            data[i].latitude
            data[i].longitude
          ].join(",") + "\">" + data[i].name + "</option>"
          i++
        $street.val("").trigger "chosen:updated"
        return
    return

  $quarter.change ->
    if $(this).val().length
      zoomToQuarter()
      $spinner.show()
      $.get "/quartier/" + $(this).val() + "/initiatives", (data) ->
        $spinner.hide()
        return

      updateStreets()
    else
      $street.empty().val("").trigger "chosen:updated"

  $street.change ->
    if( $(this).val().length )
      location = $(this).val().split(',')
      map.setView(new L.LatLng(location[0], location[1]), 16)
    else
      zoomToQuarter()
      $street.empty().val('').trigger('chosen:updated')

  zoomToQuarter = ->
    data     = quartersData[$quarter.val()]
    selected = $('#quarters').find(':selected')
    location = data.coords
    map.setView(new L.LatLng(location[1], location[0]), 14)

