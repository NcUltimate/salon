class Trick
  attr_accessor :cards, :suit

  def initialize(suit = nil)
    @suit = suit
    @cards = {}
  end

  def winner
    cards.max_by do |player, card|
      card.suit == suit ? card.rank : -card.rank
    end
  end

  def winning_player
    winner.first
  end

  def winning_card
    winner.last
  end

  def lay(player, card)
    self.suit = card.suit if suit.nil?
    cards[player] = card
  end
end
