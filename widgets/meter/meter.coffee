class Dashing.Meter extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue

  constructor: ->
    super
    @observe 'value', (value) ->
      $(@node).find(".meter").val(value).trigger('change')

  refreshWidgetState: =>
    meter = $(@node).find(".meter")
    meter.attr("data-bgcolor", meter.css("background-color"))
    meter.attr("data-fgcolor", meter.css("color"))
    meter.knob()
    node = $(@node)
    node.removeClass('up down')
    if meter.val() == '0' then node.addClass('down') else node.addClass('up')

  ready: ->
    @refreshWidgetState()

  onData: (data) ->
    @refreshWidgetState()
