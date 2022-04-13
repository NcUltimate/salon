require 'ostruct'

class GameContext
  attr_accessor :current_player, :players, :tricks, :current_trick, :game_type

  def initialize(players, game_type)
    self.players = players
    self.current_player = self.first_player
    self.current_trick = Trick.new
    self.tricks = []
    self.game_type = game_type
  end

  # two of spades always goes first
  def first_player
    @first_player ||= players.index do |player|
      player.hand.any? do |card|
        card.rank == 2 && card.suit == 2
      end
    end
  end

  def next_card!
    card = self.players[self.current_player].play_card!(self)

    self.current_trick.lay(self.current_player, card)
    self.current_player = (self.current_player + 1) % players.size

    card
  end

  def next_trick!
    self.tricks << self.current_trick
    self.current_player = self.current_trick.winning_player
    self.current_trick = Trick.new
  end

  def first_lay?
    self.current_trick.cards.empty?
  end

  def last_lay?
    self.current_trick.cards.size == self.players.size - 1
  end

  def end_trick?
    self.current_trick.cards.size == self.players.size
  end

  def first_trick?
    self.tricks.empty?
  end

  def more_tricks_playable?
    !players.first.hand.empty?
  end

  def filter_playable(cards)
    if first_trick? && first_lay?
      cards.each_index.select do |c|
        cards[c].rank == 2 && cards[c].suit == 2
      end
    else
      playable = cards.each_index.select do |cidx|
        self.current_trick.suit.nil? ||
          cards[cidx].suit == self.current_trick.suit
      end

      playable.empty? ? cards.each_index.to_a : playable
    end
  end
end
