class RiskTracker.Views.GamePlayer extends Backbone.View

  template: JST['risk_tracker/templates/game_player']

  mode: "info"

  events:
    "click .increment-territory-count": "incrementTerritoryCount"
    "click .decrement-territory-count": "decrementTerritoryCount"
    "click .save-turn":                 "endTurn"
    "click .invade":                    "invadeTerritories"
    "click .territories":               "showContinentModal"
    "click .end-invasion":              "endInvasion"
    "click .invade-player":             "invadePlayerOccupied"
    "click .invade-empty":              "invadeEmpty"
    "click .space-station":             "toggleSpaceStation"

  initialize: (@options={})->
    @game = @options.game
    @gameView = @options.gameView
    @util = new RiskTracker.Util()

    @model.bind("change:energy", @_updateEnergyDisplay)
    @model.bind("change:energy", @_updateBorderGlow)
    @model.bind("change:units", @_updateUnitsDisplay)
    @model.bind("change:territory_count", @_updateTerritoryDisplay)
    @model.bind("change:turn_order", @render)
    @model.continents.bind("add", @render)
    @model.continents.bind("remove", @render)
    _.defer(@_updateBorderGlow)

  render: ()=>
    @$el.html(@template({game_player: @model, mode: @mode}))
    @gameView.activatePlayer(@model) if @game.currentPlayer == @model
    @setupFactionInfoPopover()
    @showInfoCard() if @mode is 'info'
    @showInvadeCard() if @mode is 'invade'
    return @

  incrementTerritoryCount: (event)->
    event.preventDefault()
    @model.incrementTerritoryCount()

  decrementTerritoryCount: (event)->
    event.preventDefault()
    @model.decrementTerritoryCount()

  endTurn: (event)->
    event.preventDefault()
    if confirm("Are all the continents, territories, and space stations are recorded correctly?")
      @game.endTurn()
      @gameView.activateNextPlayer()

  invadeTerritories: (event)->
    event.preventDefault()
    @render()
    @showInvadeCard()

  _updateTerritoryDisplay: ()=>
    @_spinCounter(".territory-counter", @model.territoryCount())

  _updateUnitsDisplay: ()=>
    @_spinCounter(".unit-counter", @model.units())

  _updateEnergyDisplay: ()=>
    @_spinCounter(".energy-counter", @model.energy())

  _spinCounter: (selector, end)->
    element = @$el.find(selector)
    start = parseInt(element.html())
    return if start is end

    current = start
    i = setInterval(->
      if current is end
        clearInterval i
        element.animate {}
      else
        if start > end
          current--
        else
          current++
        element.html(current).animate {}, 100
    , 100)

  _updateBorderGlow: ()=>
    @$el.animate({boxShadow: "0 0 #{@model.borderGlow()}px"})

  showTurnControls: ()->
    saveTurnContainer = @$el.find(".save-turn-container")
    saveTurnContainer.show() unless saveTurnContainer.is(":visible")

  hideTurnControls: ()->
    saveTurnContainer = @$el.find(".save-turn-container")
    saveTurnContainer.hide() unless saveTurnContainer.is(":hidden")

  showContinentModal: (event)->
    continentType = $(event.target).data("continentType")
    if continentType is undefined
      continentType = $(event.target).parents(".territories").data("continentType")

    @gameView.showContinents(@model, continentType)

  endInvasion: (event)->
    event.preventDefault()
    @showInfoCard()

  invadePlayerOccupied: (event)->
    event.preventDefault()
    defender = @model.game.gamePlayers.find($(event.target).data("game-player-id"))
    defender.decrementTerritoryCount()
    @model.incrementTerritoryCount()
    @_spinCounter($(event.target).siblings(".opponent-counter"), defender.territoryCount())

  invadeEmpty: (event)->
    event.preventDefault()
    @model.incrementTerritoryCount()

  showInfoCard: ()->
    @mode = "info"
    @$el.find(".info-card").show()
    @$el.find(".invade-card").hide()

  showInvadeCard: ()->
    @mode = "invade"
    @$el.find(".info-card").hide()
    @$el.find(".invade-card").show()

  toggleSpaceStation: (event)->
    event.preventDefault()
    icon = $(event.target).find("img")
    icon = $(event.target) if icon.length is 0

    if icon.is(":visible")
      icon.hide()
      @model.decrementSpaceStations()
    else
      icon.show()
      @model.incrementSpaceStations()

  setupFactionInfoPopover: ()->
    content = "<b>Starts with:</b><ul>"
    _.each @model.faction.get('starting_resources'), (resource) ->
      content = content + "<li>#{resource}</li>"

    content = content + "</ul><p>#{@model.faction.get('abilities')}</p>"

    @$el.find(".faction-logo").popover(html: true, title: @model.faction.get('name'), content: content)

