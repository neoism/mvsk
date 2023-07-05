module Liz
  class Lexer
    module Keywords
      RESERVED_WORDS = {
        :if => Token::If,
        :else => Token::Else,
        :switch => Token::Switch,
        :case => Token::Case,
        :default => Token::Default,
        :for => Token::For,
        :in => Token::In,
        :loop => Token::Loop,
        :break => Token::Break,
        :continue => Token::Continue,
        :class => Token::Class,
        :extends => Token::Extends,
        :super => Token::Super,
        :self => Token::Self,
        :get => Token::Get,
        :set => Token::Set,
        :fun => Token::Fun,
        :return => Token::Return,
        :let => Token::Let,
        :mut => Token::Mut,
        :and => Token::And,
        :or => Token::Or,
        :is => Token::Is,
        :not => Token::Not,
        :import => Token::Import,
        :as => Token::As,
        :throw => Token::Throw,
        :try => Token::Try
      }
    end
  end
end

# var tokens = [...]string{
#   Int:         "<int>",
#   Float:       "<float>",
#   Identifier:  "Identifier",
#   String:      "<string>",
#   Rune:        "<rune>",
#   Bool:        "<bool>",
#   Nil:         "nil",
#   HashBang:    "#!",
#   Pipeline:    "|>",
#   Tilde:       "~",
#   Println:     "println",
#   Illegal:     "Illegal",
#   EOF:         "EOF",
