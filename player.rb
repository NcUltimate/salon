class Player
  attr_reader :hand, :strategy
  def initialize(hand, strategy = Strategy::Base)
    @hand = hand
    @strategy = strategy
  end

  def play_card!(game_context)
    #playable = game_context.filter_playable(hand)
    #binding.pry unless playable.first
    #hand.delete_at(playable.first)
    hand.delete_at(
      strategy.choose_card(game_context, hand)
    )
  end
end
