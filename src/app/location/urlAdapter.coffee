app.createAdapter 'url',

  makeURL: (params) ->
    "/#{params.page}"

  makeParams: (url) ->



  initialze: ->
    window.onpopstate = (event) ->
      @actions.goTo(@makeParams(url))

  stores:
    location: (store) ->
      window.pushState(@makeUrl(@stores.location.getLocation()))
