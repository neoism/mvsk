module Musk
  class Parser
    def initialize(tokens)
      @tokens = tokens
      @current = 0
    end

    def parse
      statements = []
      statements.push(declaration) until at_end?
      # statements.add(statement());
      statements
    end

    private

    def declaration
      begin
        #       if (match(CLASS)) return classDeclaration();
        #       if (match(FUN)) return function("function");
        #       if (match(VAR)) return varDeclaration();
        statement
      rescue ParseError
        synchronize
        nil
      end
    end

    def statement
      return if_statement if match?(Token::If)
      return for_statement if match?(Token::For)
      return loop_statement if match?(Token::Loop)
      return return_statement if match?(Token::Return)

#     if (match(LEFT_BRACE)) return new Stmt.Block(block());
#     return expressionStatement();
    end

    #   private Stmt expressionStatement() {
#     Expr expr = expression();
#     consume(SEMICOLON, "Expect ';' after expression.");
#     return new Stmt.Expression(expr);
#   }


    def synchronize
      advance

      until at_end?
        return if previous.type == Token::Semi
        return if peek.type == Token::Class
        return if peek.type == Token::Fun
        return if peek.type == Token::Return
        return if peek.type == Token::Let
        return if peek.type == Token::If
        return if peek.type == Token::Switch
        return if peek.type == Token::For
        return if peek.type == Token::Loop

        advance
      end
    end


    def expression
      assignment
    end

    def assignment

    end

#   private Expr unary() {
#     if (match(BANG, MINUS)) {
#       Token operator = previous();
#       Expr right = unary();
#       return new Expr.Unary(operator, right);
#     }
#     return call();
#   }

    def primary
      return literal(previous) if match?(Token::Nil, Token::Bool)
      return literal(previous) if match?(Token::Int, Token::Float)
      return literal(previous) if match?(Token::String)

      if match?(Token::Super)
        # Token keyword = previous();
        consume(Token::Dot, "expect '.' after 'super'")
        method = consume(Token::Identifier, 'expect superclass method name')
        return Nodes::Super.new()
        # .(keyword, method);
        # .{Method: tok.Value}
      end

      if match?(Token::Self)
        return Nodes::Self.new(previous)
      end

      if match?(Token::Identifier)
        #     tok := p.previous()
        #     return ast.Variable{Name: tok.Value}
        #       return new Expr.Variable(previous());
      end

      if match?(Token::LeftParen)
        exp = primary
        # expr = expression();
        consume(Token::RightParen, "expect ')' after expression")
        return Nodes::Grouping.new(expr: exp)
      end

      #   //   panic(ParseError{token: p.peek(), message: "Expect expression"})
      #   panic("error")
      # }
      #     throw error(peek(), "Expect expression.");
    end

    def literal(token)
      Nodes::Literal.new(type: token.type, value: token.literal)
    end

    def consume(type, message)
      return advance if check?(type)
      error peek, message
      raise ParseError
    end

    def error(tok, message)
      if tok.type == Token::EOF
#       report(token.line, " at end", message);
      else
#       report(token.line, " at '" + token.lexeme + "'", message);
      end
    end

    def match?(*types)
      types.each do |type|
        if check?(type)
          advance
          return true
        end
      end

      false
    end

    def check?(type)
      return false if at_end?
      peek.type == type
    end

    def advance
      @current += 1 unless at_end?
      previous
    end

    def previous
      @tokens[@current - 1]
    end

    def peek
      @tokens[@current]
    end

    def at_end?
      peek.type == Token::EOF
    end
  end
end
