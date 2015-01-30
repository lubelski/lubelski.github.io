app.createStore 'location',
  initialze: ->
    @update('location', {})

  api:
    getLocation: (prop) ->
      loc = @get('location')
      if prop? then @get('location')?[prop] else @get('location')

  actions:
    goTo: (payload, stores, actions) ->
      @update location: payload.location


