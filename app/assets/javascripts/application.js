// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require custom.modernizr
//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require foundation
//= require foundation.dropdown
//= require foundation.reveal
//= require foundation.tooltip
//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-de
//= require leaflet
//= require leaflet.draw-src
//= require leaflet.awesome-markers
//= require leaflet.markercluster
//= require_tree .

$(document).ready(function () {

  $('.chosen').chosen({
    default_text: 'Auswählen',
    no_results_text: 'Kein Treffer',
    allow_single_deselect: true
  })

  $('.stadtteil_dropdown').change(function () {
    window.location = '/stadtteil/' + $('#pages_quarters').val();
  })
});

