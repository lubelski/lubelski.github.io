{div, a} = React.DOM

app.createView 'base',
  render: ->
    div className: 'base',
      a className: 'contents', href: '//twitter.com/@uiwill',
        'Hello'
