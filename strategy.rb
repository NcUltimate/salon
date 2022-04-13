module Strategy
  class Base
    def self.choose_card(context, hand)
      new(context, hand).choose_card
    end

    attr_reader :context, :hand
    def initialize(context, hand)
      @context = context
      @hand = hand
    end

    def playable
      @playable ||= context.filter_playable(hand)
    end

    def must_follow_suit?
      @must_follow_suit ||= playable.any? do |idx|
        hand[idx].suit == current_suit
      end
    end

    def choose_card
      playable.first
    end

    private

    def lowest_card(indexes = playable)
      indexes.min_by { |idx| hand[idx].rank }
    end

    def highest_card(indexes = playable)
      indexes.max_by { |idx| hand[idx].rank }
    end

    def current_suit
      context.current_trick.suit
    end

    def current_winning_card
      @current_winner ||= context.current_trick.winning_card
    end
  end
end
