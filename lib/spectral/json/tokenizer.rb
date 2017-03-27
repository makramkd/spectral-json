module Spectral
  module Json
    class Tokenizer
      LEXER_EOF = -1
      EOF_TYPE = 1

      def initialize(input)
        @input = input
        @p = 0
        @c = @input[@p]
      end

      def consume
        @p += 1
        if @p >= @input.length
          @c = LEXER_EOF
        else
          @c = @input[@p]
        end
      end

      def whitespace
        while @c =~ /^\s*$/
          consume
        end
      end

      def digit?
        @c =~ /[[:digit:]]/
      end

      def match(x)
        if @c == x
          consume
        else
          raise Exception.new("Expecting #{x} but found #{@c}")
        end
      end
    end
  end
end
