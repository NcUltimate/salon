module Strategy
  class SmartRidSuit < Base
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
        highest_heart = if context.game_type == Game::Hearts
          highest_card(playable.select { |idx| hand[idx].heart? })
        end

        if !highest_heart
          # how many of each suit do we have?
          suit_distro = playable.group_by do |idx|
            hand[idx].suit
          end

          # favor eliminating a suit first. get the suit with
          # the smallest representation, and throw away the highest card.
          suit_distro.min_by { |k,v| v.size }.last.max_by { |idx| hand[idx].rank }
        else
          highest_heart
        end
      end
    end
  end
end
