require 'liz/version'
require 'liz/token'
require 'liz/lexer'

module Liz
  module_function

  def run_prompt
    require 'pastel'
    require 'readline'

    stty_save = `stty -g`.chomp

    begin
      while buf = Readline.readline('> ', true)
        break if buf.nil?
        break if buf.strip == 'exit'

        print run(buf), "\n"
        # run(line); //> reset-had-error
        # hadError = false;
      end
    rescue Interrupt
      system 'stty', stty_save
    ensure
      puts
      exit
    end
  end

  def run_file(path)
    if File.exist?(path) && File.file?(path)
      puts 'fiasd'
    else
      warn "No such file #{path}"
    end

    # run(File.read(path))
    # # if (hadError) System.exit(65);
    # # if (hadRuntimeError) System.exit(70);
  end

  def run(code)
    lexer = Lexer.new(code)
    tokens = lexer.scan_tokens
    tokens.each { |token| puts token }
  end
end

# ["And",
#  "Class",
#  "Else",
#  "False",
#  "Fun",
#  "For",
#  "If",
#  "Nil",
#  "Or",
#  "Print",
#  "Return",
#  "Super",
#  "This",
#  "True",
#  "Var",
#  "While"]
# Int
# Float
# Bool
# String
# Char
# Unit
# Tuple
# List
# Array
# Function
