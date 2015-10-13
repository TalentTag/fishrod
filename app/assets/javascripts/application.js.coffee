#= require jquery
#= require jquery_ujs
#= require foundation
#= require_tree .


page = 1

sendRequest = (options={}) ->
  $.ajax
    url: FishRod.current_location
    data:
      query: $('[role=search-field]').val()
      skip_filter: 1 if $('[name=skip_filter]').is(':checked')
      page: page
    success: (reply) ->
      if options.append
        $('#entries-list').append reply
      else
        $('#entries-list').html reply

@fetchMore = ->
  page++
  sendRequest append: true

$ ->
  $('[role=search-field]').keypress (event) ->
    page = 1
    sendRequest() if event.keyCode == 13
  $('[name=skip_filter]').change ->
    page = 1
    sendRequest()
