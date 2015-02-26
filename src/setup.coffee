window.app = pipeline.createApp(debug: window.location.hostname is 'localhost')

views = app.views = {}

helpers = app.helpers = {}

app.createView = (key, options) ->
  splitKey = key.replace( /([A-Z])/g, " $1" )
  options.displayName = splitKey.charAt(0).toUpperCase() + splitKey.slice(1)
  options._viewKey = key
  options.views = views
  options.helpers = helpers

  options.mixins = options.mixins || []

  if options.stores?
    if _.isString(options.stores) then options.stores = [options.stores]
    if options.stores.length > 0
      options.mixins.push(app.reactMixin(options.stores))
    delete options.stores

  view = React.createFactory React.createClass options
  app.views[key] = view
  view

app.createHelper = (key, fxn) ->
  keys = key.split('.')
  helper = (args...) ->
    fxn.apply(null, args)
  helper._helperKey = key
  slot = app.helpers
  namespaces = keys.slice(0, -1)
  lastKey = keys.slice(-1)[0]
  _.each(namespaces, (key) ->
    if not slot[key]? then slot[key] = {}
    slot = slot[key]
  )
  slot[lastKey] = helper
  helper
