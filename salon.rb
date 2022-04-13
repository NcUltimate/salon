require 'ostruct'
require 'pry'

require_relative 'card'
require_relative 'context'
require_relative 'deck'
require_relative 'game'
require_relative 'game/trick'
require_relative 'game/hearts'
require_relative 'player'
require_relative 'strategy'
require_relative 'strategy/highest_always'
require_relative 'strategy/lowest_always'
require_relative 'strategy/smart'
require_relative 'strategy/smart_rid_suit'
require_relative 'trick'


scores = { 0 => [], 1 => [], 2 => [] }
lowest = { 0 => 0, 1 => 0, 2 => 0 }

10000.times do
  [Game::Trick, Game::Hearts].each do |game_type|
    game = game_type.new([
      Strategy::SmartRidSuit,
      Strategy::Smart,
      Strategy::Smart
    ])

    game.scores.each do |player, score|
      scores[player] << score
    end

    game.lowest_score.each do |low|
      lowest[low.first] += 1
    end
  end
end

puts "Lowest Score Distribution:"
puts lowest
puts

puts "Average Score Distribution:"
avgs = scores.each_with_object({}) do |(player, scores), avg|
  avg[player] = scores.sum / scores.size
end
puts avgs

puts "Score Distribution:"
distros = scores.each_with_object({}) do |(player, scores), dist|
  dist[player] = scores.each_with_object({}) do |score, hash|
    hash[score] ||= 0
    hash[score] += 1
  end
end

distros.each do |player, distro|
  puts "Distribution for player #{player}"

  distro.sort { |a,b| a.first <=> b.first }.each do |score, freq|
    puts "#{score.to_s.ljust(2, ' ')} #{'|' * (freq / 100)}"
  end
end
