class RiskTracker.Models.Game extends Backbone.Model

  initialize: ()->
    @game_players = new RiskTracker.Collections.GamePlayers(@get("game_players"))
    @maps = new RiskTracker.Collections.Maps(@get("maps"))

  incrementTurnCount: ()=>
    @set({turn_count: (@get('turn_count') + 1)})