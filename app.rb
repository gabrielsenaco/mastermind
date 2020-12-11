# frozen_string_literal: true

require_relative 'game/game'

begin
  game = Game.new(12)
  game.run
rescue Interrupt
  puts "\nGame stopped, thank you."
else
  at_exit { puts 'End Game, thank you.' }
end
