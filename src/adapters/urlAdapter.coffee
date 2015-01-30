app.createAdapter 'url',

  initialze: ->
    window.onpopstate = (event) ->
      console.log(event)

  stores:
    location: (store) ->
      loc = @stores.location.getLocation()
      console.log(loc)

