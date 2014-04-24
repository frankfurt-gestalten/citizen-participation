$(document).ready(function () {
  // social share popups
  $(".share a").click(function(e) {
    e.preventDefault();
    window.open(this.href, "", "height = 500, width = 500");
  });

  // toggle the share dropdown in communities
  $(".share-label").on("click", function(e) {
    e.stopPropagation();
    var isSelected = this.getAttribute("aria-selected") == "true";
    this.setAttribute("aria-selected", !isSelected);
    $(".share-label").not(this).attr("aria-selected", "false");
  });

  $(document).on("click", function() {
    $(".share-label").attr("aria-selected", "false");
  });

  $("a.colorbox").colorbox({rel:'colorbox'})
  $('.model_quarter').change(function () {
    $('.model_street').val('');
    $('.model_street').empty();
    $('.model_street').trigger('liszt:updated');
    var name = $(this).find('option:selected').text()
    $.get('/stadtteil/' + name + '/streets', function (data) {
      for(var i = 0; i < data.length; i++) {
        $('.model_street').append('<option value="' + [data[i].latitude, data[i].longitude].join(',') +
          '">' + data[i].name + '</option>');
      }
      $('.model_street').val('').trigger('chosen:updated');
    });
  });
});

