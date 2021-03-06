class TurnsController < ApplicationController

  before_action :login_required
  before_action :find_game
  before_action :validate_owner

  def create
    @turn = @game.turns.build(turn_params)

    if !@turn.save
      render json: @turn.errors, status: :not_acceptable
    end
  end

private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def validate_owner
    if @game.creator != current_player
      head :unauthorized
    end
  end

  def turn_params
    params.permit(:order, :year, :game_player_id, game_player_stats_attributes: [:game_player_id, :energy, :units, {continent_ids: []}, :territory_count, :space_stations])
  end

end
