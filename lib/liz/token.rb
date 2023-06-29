module Onda
  class Token

    # ["LeftParen",
    # "RightParen",
    # "LeftBrace",
    # "RightBrace",
    # "Comma",
    # "Dot",
    # "Minus",
    # "Plus",
    # "Semicolon",
    # "Slash",
    # "Star"]

    attr_reader :type
    attr_reader :lexeme
    attr_reader :literal
    attr_reader :line

#   final TokenType ;
#   final String ;
#   final Object ;
#   final int ; // [location]

    def initialize()
#   Token(TokenType type, String lexeme, Object literal, int line) {
#     this.type = type;
#     this.lexeme = lexeme;
#     this.literal = literal;
#     this.line = line;
    end

  end
end

# token

#   public String toString() {
#     return type + " " + lexeme + " " + literal;
#   }
# }
