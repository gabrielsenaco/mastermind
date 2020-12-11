# frozen_string_literal: false

# Where players and bots choose their options
module GameInput
  VALID_COLORS = %w[R G O B M C].freeze
  def request(force, message, empty_input_msg = nil)
    puts message
    response = gets.chomp
    while force && response.empty?
      puts empty_input_msg
      response = gets.chomp
    end
    response
  end

  def convert_to_colors(text)
    return text if text.is_a?(Array)

    text.upcase.split('')
  end

  def invalid_colors?(colors)
    return true unless colors.is_a?(Array) && colors.size == 4

    !(colors - VALID_COLORS).empty?
  end

  def query_response(message, bot, history = nil)
    if bot
      if !history.nil?
        bot.try_break(history)
      else
        bot.random_secret_colors
      end
    else
      request(true, message, 'Empty message, try again.')
    end
  end

  def request_colors(message, bot, history = nil)
    response = query_response(message, bot, history)
    response = convert_to_colors(response)
    return request_colors(message, bot, history) while invalid_colors?(response)
    response
  end
end
