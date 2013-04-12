#= require application
#= require risk_tracker
#= require_tree ./../../fixtures

describe "RiskTracker.Views.GamePlayer", ()->

  beforeEach ()->
    @gameView = new RiskTracker.Views.Game(newGameData)
    @gameView.render()
    @view = @gameView.gamePlayerCards[0]


  describe "rendering", ()->
    it "should render", ()->
      html = @view.render().$el
      expect(html).toBeDefined()
