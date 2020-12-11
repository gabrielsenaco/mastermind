# frozen_string_literal: false

require_relative '../game/game_input'

# Replaces human actions
class Bot
  include GameInput

  def initialize
    @combinations = GameInput::VALID_COLORS.repeated_permutation(4).to_a
    @assserts = []
  end

  def random_secret_colors
    # ALTERNATIVE GameInput::VALID_COLORS.sample(4)
    colors = []
    4.times do
      colors.push(GameInput::VALID_COLORS.sample)
    end
    colors
  end

  def first_colors
    (GameInput::VALID_COLORS[0] * 2) + (GameInput::VALID_COLORS[1] * 2)
  end

  def try_break(history)
    sleep 0.2
    return first_colors if history[:colors].empty?

    reduce_combinations(history[:colors].last, history[:codes].last)

    return assserts if assserts.compact.size == 4

    combinations.shift
  end

  private

  attr_accessor :combinations, :assserts

  def reduce_combinations(last_colors, last_codes)
    last_codes.each_with_index do |code, index|
      index_color = last_colors[index]
      next delete_combinations_by(code, index, index_color) if code < 2

      assserts[index] = index_color
    end
    delete_invalid_combinations
  end

  def delete_combinations_by(code, invalid_index, invalid_color)
    case code
    when 0
      combinations.delete_if { |colors| colors.include?(invalid_color) }
    when 1
      combinations.delete_if { |colors| invalid_color == colors[invalid_index] }
    end
  end

  def delete_invalid_combinations
    combinations.delete_if do |colors|
      invalid = false
      4.times do |position|
        color = colors[position]
        asssert = assserts[position]
        invalid = asssert.nil? ? false : color != asssert
        break if invalid
      end
      invalid
    end
  end
end
