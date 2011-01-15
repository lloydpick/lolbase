module Lolbase
  module API
    module Characters
      def self.included(base)
        base.class_eval do
          @@character_profile_url = '/'.freeze
          @@character_matches_url = '/matches/player/'.freeze

          cattr_reader :character_profile_url
          cattr_reader :character_matches_url
        end
      end

      # Returns an array of results of Lolbase::Classes::SearchCharacter or an empty array.
      # Caching is disabled for searching.
      # Parameters
      # * name (String) Name of the character to search for
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (name, debug, cache etc.)
      def search_characters(name, options = {})
        if (name.is_a?(Hash))
          options = name
        else
          options.merge!(:search => name)
        end

        options.merge!(:type => 'characters')
        return search(options)
      end
    end
  end
end