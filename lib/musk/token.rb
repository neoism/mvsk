module Musk
  class Token
    class << self
      def token_type(*types)
        types.each do |type|
          const_set type, type.to_s
        end
      end
    end

    attr_reader :type, :lexeme, :literal, :line

    token_type :Plus, :Minus, :Star, :Slash, :Modulo,
               :Comma, :Colon, :Semi, :Dot,
               :LeftBrace, :RightBrace,
               :LeftSquare, :RightSquare,
               :LeftParen, :RightParen

    token_type :Bang, :BangEq, :Equal, :EqualEq,
               :Greater, :GreaterEq, :Less, :LessEq,
               :BitwiseAnd, :BitwiseOr, :And, :Or,
               :Question, :QuestionDot,
               :Pipeline

    token_type :Int, :Float, :String, :Char, :Bool, :Nil,
               :Identifier, :Illegal, :EOF

    token_type :If, :Else, :Switch, :Case, :Default,
               :For, :In, :Loop, :Break, :Continue,
               :Class, :Extends, :Super, :Self,
               :Get, :Set, :Fun, :Return,
               :Let, :Mut, :Is, :Not,
               :Import, :As,
               :Throw, :Try

    def initialize(type, lexeme, literal = nil, line)
      @type = type
      @lexeme = lexeme
      @literal = literal
      @line = line
    end

    def to_s
      return @type if @literal.nil?
      "#{@type} #{@lexeme} #{@literal}"
    end
  end
end
