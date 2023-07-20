module Musk
  class Parser
    module Helper
      def is_eof(type)
        type == Token::EOF
      end
    end
  end
end
