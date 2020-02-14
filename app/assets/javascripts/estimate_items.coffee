# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#estimate_item_option_group_name').autocomplete
    source: $('#estimate_item_option_group_name').data('autocomplete-source')
    
jQuery ->
  $('#estimate_item_part_name').autocomplete
    source: $('#estimate_item_part_name').data('autocomplete-source')
    
jQuery ->
  $('#part_search').autocomplete
    source: $('#part_search').data('autocomplete-source')