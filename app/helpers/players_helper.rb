module PlayersHelper

  def us_states_options
    States::STATES
  end

  def avatar(player, size: :large)
    image_path = player.profile_image_path(size)

    pixels = size == :large ? 150 : 50
    return image_tag(image_path, width: "#{pixels}px;", alt: player.handle)
  end

  def nearby_players(current_player)
    return if current_player.nil?
    if current_player.location.blank?
      other_players = []
    else
      begin
        nearby_players = Player.near(current_player.location, 50).except(current_player)
      rescue Exception => exception
        nearby_players = []
      end
    end
    render partial: "players/nearby_players", locals: {nearby_players: nearby_players, current_player: current_player}
  end

  def message_link(current_player, player, label="Message")
    return if current_player.nil?
    return link_to(content_tag(:i, "", class: "icon-envelope") + " #{label}", new_message_path(recipient: player.slug), class: "btn btn-mini btn-info")
  end

end
