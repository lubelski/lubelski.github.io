app.createHelper('cx', (classObjects...) ->
  _(classObjects)
    .map((classObject) ->

      if _.isObject(classObject)
        _.reduce(classObject, ((classes, exp, key) ->
          if exp then classes.push(key)
          return classes
        ), [])

      else if _.isArray(classObject)
        return _.filter(classObject, (item) -> typeof item is 'string')

      else if _.isString(classObject)
        return classObject

    )
    .flatten()
    .compact()
    .unique()
    .join(' ')
)
