{div, a} = React.DOM

app.createView 'base',

  stores: ['location']

  getInitialState: -> @getLocation()

  onLocationChange: -> @setState(@getLocation())

  getLocation: -> page: app.stores.location.getLocation('page')

  render: ->
    contents = switch @state.page
      when 'todo' then @views.todoPage()
      else a className: 'contents', href: '//twitter.com/@uiwill', "Hello"


    div className: 'base',
      contents


