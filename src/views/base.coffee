{div} = React.DOM

app.createView 'base',
  render: ->
    div className: 'base',
      div className: 'contents',
        'Hello'
