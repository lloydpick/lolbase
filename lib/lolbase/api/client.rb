module Lolbase
  module API
    module Client

      class LolbaseClient
        include HTTParty
        include HTTParty::Icebox
        headers 'User-Agent' => 'lolbase ruby gem'
      end

      def self.included(base)
        base.class_eval do
          @@base_url = 'lolbase.net'.freeze
          @@search_url = '/search'.freeze
          @@max_connection_tries = 10.freeze
          @@cache_directory_path = 'cache/'
          @@failed_cache_timeout = (60*60*24)
          @@cache_failed_requests = true

          cattr_reader :base_url
          cattr_reader :search_url
          cattr_reader :max_connection_tries
          cattr_reader :cache_directory_path
          cattr_reader :failed_cache_timeout
          cattr_reader :cache_failed_requests
        end
      end

    end
  end
end