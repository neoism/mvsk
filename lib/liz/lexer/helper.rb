module Liz
  class Lexer
    module Helper
      def is_alpha_numeric(char)
        is_alpha(char) || is_digit(char)
      end

      def is_alpha(char)
        ('A' <= char && char <= 'Z') ||
        ('a' <= char && char <= 'z') ||
        ('_' == char)
      end

      def is_digit(char)
        '0' <= char && char <= '9'
      end

      def is_bool(str)
        str == 'true' || str == 'false'
      end

      def is_nil(str)
        str == 'nil'
      end
    end
  end
end
