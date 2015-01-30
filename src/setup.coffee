window.app = pipeline.createApp(debug: window.location.hostname is 'localhost')

app.views = {}

app.createView = (key, options) ->
  splitKey = key.replace( /([A-Z])/g, " $1" )
  options.displayName = splitKey.charAt(0).toUpperCase() + splitKey.slice(1)
  options.key = key
  view = React.createFactory React.createClass options
  app.views[key] = view
  view
