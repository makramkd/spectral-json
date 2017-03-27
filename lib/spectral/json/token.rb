module Spectral
  module Json
    class Token
      # Token Types
      # Number types
      INTEGER = 0
      FLOATING_POINT = 1

      STRING = 2

      # Keywords
      TRUE_KEYWORD = 3
      FALSE_KEYWORD = 4
      NULL_KEYWORD = 5

      # Important character
      LBRACE = 6
      RBRACE = 7
      LBRACK = 8
      RBRACK = 9
      COLON = 10

      # End of File
      EOF_TYPE = 66

      def initialize(token_type, token_text)
        @type = token_type
        @text = token_text
      end

      def to_s
        "<'#{@text}', #{tokname(@type)}>"
      end

      private

      def tokname(type)
        case type
        when INTEGER
          "INTEGER"
        when FLOATING_POINT
          "FLOATING_POINT"
        when TRUE_TOK
          "TRUE"
        when FALSE_TOK
          "FALSE"
        when NULL_TOK
          "NULL"
        when LBRACE
          "LEFT_BRACE"
        when RBRACE
          "RIGHT_BRACE"
        when LBRACK
          "LEFT_BRACK"
        when RBRACK
          "RIGHT_BRACK"
        when COLON
          "COLON"
        end
      end
    end
  end
end
