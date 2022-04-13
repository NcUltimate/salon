class Deck
  SIZE = 52
  include Enumerable

  attr_reader :cards
  def initialize
    @cards = []
    (2..14).each do |rank|
      (0..3).each do |suit|
        @cards << Card.new(rank: rank, suit: suit)
      end
    end
    @cards.shuffle!
  end

  def each(&block)
    cards.each(&block)
  end

  def deal(n = 1)
    cards.shift(n)
  end

  def to_s
    cards.each do |card|
      puts card
    end
  end
end
