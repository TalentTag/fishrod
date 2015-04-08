#= require jquery
#= require jquery_ujs
#= require foundation
#= require_tree .


$ ->
  $('[role=search-field]').keypress (event) ->
    if event.keyCode == 13
      $.ajax
        url: "#{ FishRod.current_location }?query=#{ $(@).val() }"
        success: (reply) ->
          $('#entries-list').html reply
