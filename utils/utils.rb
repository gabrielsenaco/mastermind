# frozen_string_literal: true

# Module with utilities
module Utils
  def clear_console
    system('clear') || system('cls')
  end
end
