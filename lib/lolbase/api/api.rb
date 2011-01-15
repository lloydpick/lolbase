module Lolbase
  module API
    class API
      attr_accessor :character_name, :region, :caching, :cache_timeout, :debug

      include Client

      include Characters

      def initialize(options = {})
        @character_name = options[:character_name]
        @region         = options[:region].nil? ? 'eu' : options[:region]
        @caching        = options[:caching].nil? ? true : options[:caching]
        @cache_timeout  = options[:cache_timeout] || (7*24*60*60)
        @debug          = options[:debug] || false
      end

      # General-purpose search
      # All specific searches are wrappers around this method. Best to use those instead.
      # Returns an array of results of the type requested (Lolbase::Classes::SearchCharacter etc.) or an empty array.
      # Caching is disabled for searching.
      # * string (String) Search string
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (name, debug, cache etc.)
      def search(string, options = {})
        if (string.is_a?(Hash))
          options = string
        else
          options.merge!(:search => string)
        end

        options = merge_defaults(options)

        if options[:search].nil? || options[:search].empty?
          raise Lolbase::Exceptions::NoSearchString.new
        end

        if !valid_search_type?(options[:type])
          raise Lolbase::Exceptions::InvalidSearchType.new(options[:type])
        end

        options.merge!(:caching => false)

        data = post_html(@@search_url, options)

        results = []

        if (data)
          case options[:type]

          when 'characters'
            data.xpath('//div[@class="table"]/table/tbody/tr').each do |char|
              results << Lolbase::Classes::SearchCharacter.new(char, self)
            end
          end
        end

        return results
      end

      private

      # Determines if the given +value+ is a valid search type
      def valid_search_type?(value)
        %w(characters).include? value
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