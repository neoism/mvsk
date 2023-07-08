module Liz
  module Nodes
    class Node
      def accept(visitor)
        raise NotImplementedError
      end
    end

    class Program < Node; end
    class Expression < Node; end
    class Statement < Node; end
    class Declaration < Statement; end

    class BlockStatement < Statement
      attr_reader :statements

      def initialize(statements:)
        @statements = statements
      end

      def accept(visitor)
        visitor.visit_block_stmt(self)
      end
    end

    class IfStatement < Statement
      #   //   Condition Expression
      #   //   Then Statement
      #   //   Else Statement
    end

    class ForStatement < Statement
    end

    class LoopStatement < Statement
      #   //   Condition Expression
      #   //   Body Statement
    end

    class ContinueStatement < Statement
      # Label Expression
    end

    class BreakStatement < Statement
      # Label Expression
    end

    class ReturnStatement < Statement
      attr_reader :keyword, :value

      def initialize(keyword:, value:)
        @keyword = keyword
        @value = value
        # Argument Expression
      end

      def accept(visitor)
        visitor.visit_return_stmt(self)
      end
    end

    class ExpressionStatement < Statement
      attr_reader :expression

      def initialize(expression:)
        @expression = expression
      end

      def accept(visitor)
        visitor.visit_expression_stmt(self)
      end
    end

    class ClassDeclaration < Declaration
      # //   Name        token.Token
      # //   Methods     []ClassMethod
      # //   SuperClass  *VariableExpression
    end

    class VariableDeclaration < Declaration
      # //   Name        token.Token
      # //   Initializer Expression
    end

    class FunctionDeclaration < Declaration
      attr_reader :name, :params, :body

      def initialize(name:, params:, body:)
        @name = name
        @params = params
        @body = body
      end

      def accept(visitor)
        visitor.visit_function_stmt(self)
      end
    end

    class Function < Expression
      attr_reader :params, :body

      def initialize(params:, body:)
        @params = params
        @body = body
      end
    end

    class Assignment < Expression
      #   Operator token.Token
      #   Right    Expression
      #   Left     Expression
      #   //> expr-assign
      #   static class Assign extends Expr {
      #     Assign(Token name, Expr value) {
      #       this.name = name;
      #       this.value = value;
      #     <R> R accept(Visitor<R> visitor) {
      #       return visitor.visitAssignExpr(this);
      #     final Token name;
      #     final Expr value;
    end

    # type Variable struct {
    #   Name string
    #   Expression
    # }

    # type Identifier struct {
    #   Name string
    #   Expression
    # }

    class Call < Expression
      attr_reader :callee, :args

      def initialize(callee:, args:)
        @callee = callee
        @args = args
        # final Token paren;
        # this.paren = paren;
      end

      def accept(visitor)
        visitor.visit_call_expr(self)
      end
    end

    class Logical < Expression
      attr_reader :left, :operator, :right

      def initialize(left:, operator:, right:)
        @left = left
        @operator = operator
        @right = right
      end

      def accept(visitor)
        visitor.visit_logical_expr(self)
      end
    end

    class Grouping < Expression
      attr_reader :expr

      def initialize(expr:)
        @expr = expr
      end

      def accept(visitor)
        visitor.visit_grouping_expr(self)
      end
    end

    class Binary < Expression
      attr_reader :left, :operator, :right

      def initialize(left:, operator:, right:)
        @left = left
        @operator = operator
        @right = right
      end

      def accept(visitor)
        visitor.visit_binary_expr(self)
      end
    end

    class Unary < Expression
      attr_reader :operator, :right

      def initialize(operator:, right:)
        @operator = operator
        @right = right
      end

      def accept(visitor)
        visitor.visit_unary_expr(self)
      end
    end

    class Literal < Expression
      attr_reader :type, :value

      def initialize(type:, value:)
        @type = type
        @value = value
      end

      def accept(visitor)
        visitor.visit_literal_expr(self)
      end
    end
  end
end
