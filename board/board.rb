# frozen_string_literal: true

# Draw the game.
class Board
  attr_reader :history

  def initialize
    @history = { messages: [], colors: [], codes: [] }
  end

  def draw(colors, status_codes)
    draw_message = history[:messages].empty? ? "#{draw_separator}\n" : ''
    draw_message += draw_lines(colors, status_codes) + draw_separator

    history[:messages].push(draw_message)
    history[:colors].push(colors)
    history[:codes].push(status_codes)

    draw_message
  end

  def draw_history
    history.join("\n")
  end

  private

  def draw_lines(colors, status_codes)
    line = '|'
    colors.each { |color| line += " #{colorize(color) * 3}" }
    line += ' | '
    codes = draw_codes(status_codes)

    str1 = "#{line}#{codes[0..1].join(' ')} |"
    str2 = "#{line}#{codes[2..3].join(' ')} |"
    <<~LINES_DISPLAY
      #{str1}
      #{str2}
    LINES_DISPLAY
  end

  def draw_codes(codes)
    codes.reduce([]) do |total, stat|
      case stat
      when 1
        total.push("\e[1m●\e[22m")
      when 2
        total.push('●')
      when 0
        total.push(' ')
      end
    end
  end

  def draw_separator
    '+-----------------+-----+'
  end

  def colorize(color)
    color = color.upcase
    case color
    when 'R'
      "\e[31mR\e[0m"
    when 'G'
      "\e[32mG\e[0m"
    when 'O'
      "\e[33mO\e[0m"
    when 'B'
      "\e[34mB\e[0m"
    when 'M'
      "\e[35mM\e[0m"
    when 'C'
      "\e[36mC\e[0m"
    else
      'E'
    end
  end
end
