module Liz
  class Token
    class << self
      def token_type(*types)
        types.each do |type|
          const_set type, type.to_s
        end
      end
    end

    attr_reader :type,
                :lexeme,
                :literal,
                :line

    token_type :Plus, :Minus, :Star, :Slash,
               :Semicolon, :Comma, :Dot,
               :LeftParen, :RightParen,
               :LeftBrace, :RightBrace

    token_type :Bang, :BangEqual,
               :Equal, :EqualEqual,
               :Greater, :GreaterEqual,
               :Less, :LessEqual

    token_type :Int, :Float, :Bool,
               :String, :Char,
               :Identifier,
               :EOF

    def initialize(type:, lexeme:, literal: nil, line:)
      @type = type
      @lexeme = lexeme
      @literal = literal
      @line = line
    end

    def to_s
      return @type if @literal.nil?
      "#{@type} {#{@lexeme}} #{@literal}"
    end
  end
end
