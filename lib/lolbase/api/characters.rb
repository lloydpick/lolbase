module Lolbase
  module API
    module Characters
      def self.included(base)
        base.class_eval do
          @@character_profile_url = '/'.freeze
          @@character_matches_url = '/matches/player/'.freeze
        end
      end
    end
  end
end