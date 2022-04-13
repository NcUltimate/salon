module Game
  class Hearts < Base
    def scores
      play! unless played?
      return @scores unless @scores.empty?

      @scores = context.tricks.each_with_object({}) do |trick, scores|
        scores[trick.winning_player] ||= 0
        scores[trick.winning_player] += (5 * trick.cards.count { |_, c| c.heart? })
      end
    end
  end
end
