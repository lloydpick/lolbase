module Lolbase
  module Exceptions
    def self.raise_me(code, options = {})
      case code
        when "noCharacter"
          raise CharacterNotFound.new(options[:character_name])
        else
          raise StandardError.new("The site returned an error: #{code.to_s}")
      end
    end

    class InvalidXML < StandardError
    end

    class EmptyPage < StandardError
    end

    class ServerDoesNotExist < StandardError
      def initialize(string)
        super "Server at '#{string}' did not respond."
      end
    end

    class CharacterNameNotSet < StandardError
      def initialize
        super "Character name not set in options or API constructor."
      end
    end

    # Search (fold)
    class SearchError < StandardError
    end

    class InvalidSearchType < SearchError
      def initialize(string)
        super "'#{string}' is not a valid search type."
      end
    end

    class NoSearchString < SearchError
      def initialize
        super "No search string specified or string was empty."
      end
    end

    class ElementNotFoundError < StandardError
    end

    class CharacterNotFound < ElementNotFoundError
      def initialize(string)
        super "Character not found with name '#{string}'."
      end
    end

    class NetworkTimeout < StandardError
      def initialize(string)
        super "Network timeout '#{string}'."
      end
    end
  end
end
