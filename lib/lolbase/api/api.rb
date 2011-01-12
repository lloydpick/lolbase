module Lolbase
  module API
    class API
      attr_accessor :character_name, :region, :caching, :cache_timeout, :debug

      #include Character

      def initialize(options = {})
        @character_name = options[:character_name]
        @region         = options[:region].nil? ? 'eu' : options[:region]
        @caching        = options[:caching].nil? ? true : options[:caching]
        @cache_timeout  = options[:cache_timeout] || (7*24*60*60)
        @debug          = options[:debug] || false
      end

      # Merge the defaults specified in the constructor with those supplied,
      # overriding any defaults with those supplied
      def merge_defaults(options = {})
        defaults = {}
        # defaults[:character_name] = @charater_name if @charater_name
        defaults[:region]         = @region         if @region
        defaults[:caching]        = @caching        if @caching
        defaults[:cache_timeout]  = @cache_timeout  if @cache_timeout
        defaults[:debug]          = @debug          if @debug

        # overwrite defaults with any given options
        defaults.merge!(options)
      end
    end
  end
end