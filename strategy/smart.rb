module Strategy
  class Smart < Base
    def choose_card
      # If I'm going first, throw any of my lowest cards
      if context.first_lay?
        lowest_card
      elsif must_follow_suit?
        # parition cards into lower and higher than the current lead
        lower, higher = playable.partition do |idx|
          hand[idx].rank < current_winning_card.rank
        end

        # try to throw the highest card lower than the winner
        if lower.any?
          lower.max
        else
          # if no cards are lower, if it's the last trick, throw the 
          # highest of the high cards
          if context.last_lay?
            higher.max
          else
            # otherwise, throw the min of higher cards, hoping
            # another player has a higher card.
            higher.min
          end
        end
      else
        highest_card
      end
    end
  end
end
