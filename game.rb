module Game
  DEBUG = false

  class Base
    attr_reader :players, :context, :deck, :scores
    def initialize(player_types = [])
      @players = []
      @scores = {}

      return unless player_types.size > 1

      @deck = Deck.new
      num_to_skip = (@deck.count % player_types.size)
      while @deck.deal(num_to_skip).any?(&:lead?)
        @deck = Deck.new
      end

      player_types.each do |player_type|
        @players << Player.new(
          @deck.deal(Deck::SIZE / player_types.size),
          player_type
        )
      end

      @context = GameContext.new(players, self.class)
    end

    def play!
      return unless players.size > 1

      while context.more_tricks_playable?
        puts "---- Trick #{context.tricks.size + 1} ----" if Game::DEBUG

        cards = {}
        while !context.end_trick?
          player = context.current_player
          player_card = context.next_card!
          cards[player] = player_card
          puts "Player #{player}: #{player_card}" if Game::DEBUG
        end

        puts "Winner: #{context.current_trick.winner}" if Game::DEBUG

        context.next_trick!
      end

      @played = true
    end

    def lowest_score
      min = scores.min_by(&:last)
      scores.select { |p, s| s == min.last }
    end

    def played?
      @played
    end
  end
end
