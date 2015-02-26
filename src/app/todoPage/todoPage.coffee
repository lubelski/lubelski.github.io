{div, a} = React.DOM

app.createView 'todoPage',

  render: ->
    div className: 'todo-page',
      "To Do Page ", app.views.Link(href: '/butts', 'This is a Link')

