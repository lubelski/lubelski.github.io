app.createStore 'location',
  initialize: ->
    @update('location', page: 'todo')

  siteMap:
    page:
      home: true
      todo: true
      about: true

  isValidPage: (page) -> @siteMap.page[page]?

  api:
    getLocation: (prop) ->
      loc = @get('location')
      if prop? then @get('location')?[prop] else @get('location')

  actions:
    goTo: (payload) ->
      if payload.location
        @update location: payload.location
      else if @isValidPage(payload.page)
        @update location: page: payload.page
      else
        console.log('error, wacked out goTo, payload: ', payload)


