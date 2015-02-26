app.createView 'Link',
  propTypes:
    onClick: React.PropTypes.func

  getDefaultProps: ->
    className: ''
    href: '#'

  getInitialState: ->
    isHovered: false

  makeHref: (location) -> "#{location}"

  render: ->
    that = this

    props = _.omit(@props, ['className', 'onMouseEnter', 'onMouseLeave', 'children'])

    props.onMouseEnter = (evt) ->
      that.setState isHovered: false
      if _.isFunction(that.props.onMouseEnter)
        that.props.onMouseEnter.call(this, evt)

    props.onMouseLeave = (evt) ->
      that.setState isHovered: false
      if _.isFunction(that.props.onMouseLeave)
        that.props.onMouseEnter.call(this, evt)

    props.className = app.helpers.cx(
      'link-component',
      @props.className,
      {'is-active': @state.isActive, 'is-hovered': @state.isHovered}
    )

    if _.isFunction(@props.onClick) then props.onClick = @props.onClick

    else if @props.location?
      props.onClick = (event) =>
        event.preventDefault()
        app.actions.location.goTo(@props.location)
      props.href = @makeHref(location)

    else if @props.menu?
      props.onClick = (event) =>
        event.preventDefault()
        app.actions.menu.open(@props.menu)

    React.DOM.a(props, @props.children)
