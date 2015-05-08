#= require jquery
#= require jquery_ujs
#= require foundation
#= require_tree .


$ ->
  sendRequest = ->
    if query = $('[role=search-field]').val()
      $.ajax
        url: FishRod.current_location
        data:
          query: query
          skip_filter: 1 if $('[name=skip_filter]').is(':checked')
        success: (reply) ->
          $('#entries-list').html reply

  $('[role=search-field]').keypress (event) ->
    sendRequest() if event.keyCode == 13
  $('[name=skip_filter]').change sendRequest
