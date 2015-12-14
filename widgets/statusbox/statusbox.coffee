class Dashing.Statusbox extends Dashing.Widget

  constructor: ->
    super

  refreshWidgetState: =>
    node = $(@node)
    node.removeClass('ok down')
    node.addClass(@get('text').toLowerCase())

  ready: ->
    @refreshWidgetState()

  onData: (data) ->
    @refreshWidgetState()