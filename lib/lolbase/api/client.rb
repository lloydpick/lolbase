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
          @@search_url = 'search'.freeze
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

      def base_url(options = {})
        # Non-secure only
        str = 'http://'
        str += @@base_url
      end

      protected

      # Given a url and a hash of query parameters, fetches a file from the site
      def get_file(url, options = {})
        client = LolbaseClient
        client.base_uri(self.base_url(options) + "/")

        if options[:caching]
          client.cache :store => 'file', :timeout => @cache_timeout, :location => @@cache_directory_path
        else
          # Default setting
          client.cache :store => 'memory', :timeout => 60
        end

        begin
          client.get(url).response.body
        rescue Timeout::Error => e
          raise Lolbase::Exceptions::NetworkTimeout.new('Timed out - Timeout::Error Exception')
        rescue SocketError, Net::HTTPExceptions => e
          raise Lolbase::Exceptions::ServerDoesNotExist.new('Specified server at ' + url + ' does not exist.')
        end
      end

    end
  end
end