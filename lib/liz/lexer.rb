module Liz
  class Lexer
    include Helper
    attr_reader :tokens

    def initialize(code)
      @tokens = []
      @input = code
      @line = 1
      @start = 0
      @current = 0
    end

    def next_token
      until at_end?
        @start = @current
        break if scan_token
      end

      @tokens.last
    end

    private

    def scan_token
      char = advance

      return false if skip_whitespace(char)

      #   if l.skipComment(c) {
      #     return false
      #   }

      single_token(char) ||
      number_token(char)

      #   return l.(c) ||
      #          l.doubleToken(c) ||
      #          l.tripleToken(c) ||
      #          l.stringToken(c) ||
      #          l.numberToken(c) ||
      #          l.identifierToken(c)
    end

    def skip_whitespace(char)
      if char == "\n"
        @line += 1
        return true
      end

      char == "\r" ||
      char == "\t" ||
      char == ' '
    end

    def skip_comment(char)

      # func (l *Lexer) (c rune) bool {
      #   if c == '/' && l.match('/') {
      #     for {
      #       if l.peek() == '\n' || l.isEnd() {
      #         break
      #       }
      #       l.advance()
      #     }
      #     return true
      #   }
      #   return false
      # }

    end

    def number_token(char)
      if is_digit(char)
        while is_digit(peek)
          advance
        end

        if peek == '.' && is_digit(peek_next)
          advance

          while is_digit(peek)
            advance
          end
        end

        lexeme = @input[@start...@current]

        if lexeme.include?('.')
          add_token(Token::Float, lexeme, lexeme.to_f)
        else
          add_token(Token::Int, lexeme, lexeme.to_i)
        end

        true
      else
        false
      end
    end

    def single_token(char)
      case char
      when '+' then add_token(Token::Plus)
      when '-' then add_token(Token::Minus)
      when '*' then add_token(Token::Star)
      when '/' then add_token(Token::Slash)
      when '%' then add_token(Token::Modulo)
      when ',' then add_token(Token::Comma)
      when ':' then add_token(Token::Colon)
      when ';' then add_token(Token::Semi)
      when '.' then add_token(Token::Dot)
      when '{' then add_token(Token::LeftBrace)
      when '}' then add_token(Token::RightBrace)
      when '[' then add_token(Token::LeftSquare)
      when ']' then add_token(Token::RightSquare)
      when '(' then add_token(Token::LeftParen)
      when ')' then add_token(Token::RightParen)
      else
        return false
      end

      true
    end

    def add_token(type, lexeme = nil, literal = nil)
      lexeme = @input[@start...@current] if lexeme.nil?
      @tokens.push(Token.new(type, lexeme, literal, @line))
    end

    def match?(char)
      return false if at_end?
      return false if @input[@current] != char

      @current += 1
      true
    end

    def peek
      return "\0" if at_end?
      @input[@current]
    end

    def peek_next
      if @current + 1 < @input.length
        @input[@current + 1]
      else
        "\0"
      end
    end

    def advance
      char = @input[@current]
      @current += 1
      char
    end

    def at_end?
      @current >= @input.length
    end
  end
end
