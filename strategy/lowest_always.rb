module Strategy
  class LowestAlways < Base
    def choose_card
      lowest_card
    end
  end
end
