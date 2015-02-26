app.createHelper 'location.product', (args...) ->
  _.reduce(args, (product, arg) -> product = product * arg)
