require 'stringio'
require 'spectral/json/tokenizer'
require 'spectral/json/token'

module Spectral
  module Json
    class JsonTokenizer < Tokenizer

      def next_token
        while @c != LEXER_EOF
          case @c
          when ' ', '\t', '\n', '\r'
            whitespace
            next
          when ':'
            consume
            return Token.new(Token::COLON, ':')
          when '{'
            consume
            return Token.new(Token::LBRACE, '{')
          when '}'
            consume
            return Token.new(Token::RBRACE, '}')
          when '['
            consume
            return Token.new(Token::LBRACK, '[')
          when ']'
            consume
            return Token.new(Token::RBRACK, ']')
          when 't'
            return true_keyword
          when 'f'
            return false_keyword
          when 'n'
            return null_keyword
          when '"'
            return string
          else
            if digit?
              return number
            else
              raise Exception.new("Invalid character: #{@c}")
            end
          end
        end
        return Token.new(Token::EOF_TYPE, "<EOF>")
      end

      private

      def number
        ss = StringIO.new
        num_periods = 0
        loop do
          if @c == '.'
            num_periods += 1
          end
          if num_periods > 1
            raise Exception.new("Invalid number")
          end
          ss << @c
          consume
          break if !is_digit && @c != '.'
        end
        str = ss.string
        if str.include?('.')
          Token.new(Token::FLOATING_POINT, str)
        else
          Token.new(Token::INTEGER, str)
        end
      end

      def string
        ss = StringIO.new
        loop do
          ss << @c
          consume
          break if @c == '"'
        end
        # consume the " character
        ss << @c
        consume
        Token.new(Token::STRING, ss.string)
      end

      def true_keyword
        ss = StringIO.new
        loop do
          ss << @c
          consume
          break if !letter?
        end
        str = ss.string
        if str != 'true'
          raise Exception.new("Expected keyword true, got #{str}")
        end
        Token.new(Token::TRUE_KEYWORD, str)
      end

      def false_keyword
        ss = StringIO.new
        loop do
          ss << @c
          consume
          break if !letter?
        end
        str = ss.string
        if str != 'false'
          raise Exception.new("Expected keyword false, got #{str}")
        end
        Token.new(Token::FALSE_KEYWORD, str)
      end

      def null_keyword
        ss = StringIO.new
        loop do
          ss << @c
          consume
          break if !letter?
        end
        str = ss.string
        if str != 'null'
          raise Exception.new("Expected keyword null, got #{str}")
        end
        Token.new(Token::NULL_KEYWORD, str)
      end
    end
  end
end
