require 'liz/lexer/keywords'
require 'liz/lexer/helper'

module Liz
  class Lexer
    include Helper
    include Keywords

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

      @token_i = 0 if @token_i.nil?
      @token_i += 1

      if @token_i <= @tokens.size
        @tokens.last
      else
        nil
      end
    end

    private

    def scan_token
      char = advance

      return false if skip_whitespace(char)
      return false if skip_comment(char)

      single_token(char) ||
      double_token(char) ||
      triple_token(char) ||
      string_token(char) ||
      number_token(char) ||
      identifier_token(char)
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
      if char == '/' && match?('/')
        until peek == "\n" || at_end?
          advance
        end

        true
      else
        false
      end
    end

    def identifier_token(char)
      if is_alpha(char)
        while is_alpha_numeric(peek)
          advance
        end

        lexeme = @input[@start...@current]

        if is_bool(lexeme)
          add_token_bool(lexeme)
        elsif is_nil(lexeme)
          add_token(Token::Nil, 'nil')
        else
          if type = RESERVED_WORDS[lexeme.to_sym]
            add_token(type, lexeme)
          else
          end
        end

        true
      else
        add_token(Token::Illegal, nil, "unexpected '#{char}'")
        false
      end
    end

    def string_token(char)
      if char == '"'
        until peek == '"' || at_end?
          if peek == "\n"
            @line += 1
          end

          advance
        end

        if at_end?
          add_token(Token::Illegal, nil, 'unterminated string')
          return false
        end

        advance
        add_token_string(@input[@start...@current])

        true
      else
        false
      end
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

          add_token_float(@input[@start...@current])
        else
          add_token_int(@input[@start...@current])
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

    def double_token(char)
      case char
      when '!'
        if match?('=')
          add_token(Token::BangEq)
        else
          add_token(Token::Bang)
        end
      when '='
        if match?('=')
          add_token(Token::EqualEq)
        else
          add_token(Token::Equal)
        end
      when '>'
        if match?('=')
          add_token(Token::GreaterEq)
        else
          add_token(Token::Greater)
        end
      when '<'
        if match?('=')
          add_token(Token::LessEq)
        else
          add_token(Token::Less)
        end
      when '?'
        if match?('.')
          add_token(Token::QuestionDot)
        else
          add_token(Token::Question)
        end
      else
        return false
      end

      true
    end

    def triple_token(char)
      case char
      when '&'
        if match?('&')
          if match?('=')
            add_token(Token::Illegal)
          else
            add_token(Token::And)
          end
        else
          add_token(Token::BitwiseAnd)
        end
      when '|'
        if match?('|')
          if match?('=')
            add_token(Token::Illegal)
          else
            add_token(Token::Or)
          end
        else
          if match?('>')
            add_token(Token::Pipeline)
          else
            add_token(Token::BitwiseOr)
          end
        end
      else
        return false
      end

      true
    end

    def add_token_bool(lexeme)
      value = lexeme.eql?('true')
      add_token(Token::Bool, lexeme, value)
    end

    def add_token_string(lexeme)
      value = lexeme[1, lexeme.length - 2]
      add_token(Token::String, lexeme, value)
    end

    def add_token_float(lexeme)
      add_token(Token::Float, lexeme, lexeme.to_f)
    end

    def add_token_int(lexeme)
      add_token(Token::Int, lexeme, lexeme.to_i)
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
