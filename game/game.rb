# frozen_string_literal: false

require_relative 'game_input'
require_relative 'game_setup'
require_relative '../board/board'
require_relative '../utils/utils'
require_relative '../player/bot'

# Here you control the game: start, check if there is a winner and inform the winner
class Game
  include GameInput
  include Utils
  attr_reader :board, :players

  def initialize(max_tries = 12)
    @board = Board.new
    @tries = 1
    @max_tries = max_tries
  end

  def run
    setup = GameSetup.new
    @players = setup.setup_players
    request_secret_colors
    request_decrypt_colors
  end

  def draw
    clear_console
    puts board.history[:messages].join("\n")
  end

  private

  attr_accessor :secret_colors, :tries, :max_tries

  def request_secret_colors
    self.secret_colors = request_colors('Insert your secret colors:',
                                        players[:bot_codemaker], nil)
    clear_console
  end

  def request_decrypt_colors
    request_message = if tries > 1
                        "Try again:\nColors:
    #{GameInput::VALID_COLORS.join(', ')}"
                      else
                        'Insert colors to break:'
                      end
    colors_breaker = request_colors(request_message, players[:bot_codebreaker],
                                    board.history.filter { |item| item != :messages })

    broken = try_break(colors_breaker)
    draw

    return if winner?(broken)

    self.tries += 1
    request_decrypt_colors
  end

  def winner?(broken)
    return finish(true) if broken
    return finish(false) if tries == max_tries
  end

  def try_break(colors_breaker)
    codes = []
    colors_breaker.each_with_index do |color, index|
      codes.push(determine_code(color, index))
    end
    board.draw(colors_breaker, codes)
    code_broken?(codes)
  end

  def determine_code(color, index)
    code = 0
    secret_colors.each_with_index do |sec_color, sec_index|
      code = 2 if sec_color == color && sec_index == index
      break if code == 2

      code = 1 if sec_color == color
      next if code == 1
    end
    code
  end

  def code_broken?(codes)
    codes.count { |code| code == 2 } == 4
  end

  def finish(decrypted)
    board.draw(secret_colors, [2, 2, 2, 2])
    draw
    puts 'Game finish!'
    if decrypted
      puts 'The codebreaker won!'
    else
      puts 'The codemaker won!'
    end
    true
  end
end
