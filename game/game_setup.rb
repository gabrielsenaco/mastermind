# frozen_string_literal: true

require_relative 'game_input'
require_relative '../player/bot'

# Where the player decides the format of the game: Player vs. Player, Bot vs. Bot or Bot vs. Player.
class GameSetup
  include GameInput

  def query_message
    <<~QUERY
      Please, set how players are:
       - 0 for bot
       - 1 for player
       - skip(press enter) for default(codemaker: player, codebreaker: player)
      to set, see examples:
        - 00 = bot as codemaker, bot as codebreaker
        - 11 = player as codemaker, player as codemaker
        - 10 = player as codemaker, bot as codebreaker
    QUERY
  end

  def setup_players
    response = request(false, query_message)
    response = if response.size != 2
                 [1, 1]
               else
                 response.split('').map(&:to_i)
               end
    { bot_codemaker: !response[0].positive? ? Bot.new : false,
      bot_codebreaker: !response[1].positive? ? Bot.new : false }
  end
end
