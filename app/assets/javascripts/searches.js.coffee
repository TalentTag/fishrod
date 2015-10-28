$ ->
  $('[role=search-form-toggle]').click ->
    $(@).parents('.search-item').toggleClass('current')
  $('[role=search-form-cancel]').click ->
    $(@).parents('.search-item').removeClass('current')
  $('[role=create-search]').click ->
    $(@).siblings('.search-item').toggleClass('current')
