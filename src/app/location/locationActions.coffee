app.createAction 'goTo', (location) ->
  if typeof location is 'object'
    location: location
  else if typeof location is 'string'
    page: location
  else
    false
