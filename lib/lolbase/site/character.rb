module Lolbase
  module Site
    module Character
      # Basic character info
      #
      # This class is used when only partial character information is
      # available, such as in search results.
      #
      # Depending on the type of listing this class represents, some data may
      # be missing. This is a limitation of the information returned by the
      # site.

      class Base

        attr_reader :id
        attr_reader :name
        attr_reader :level
        attr_reader :url
        attr_reader :region
        attr_reader :last_update

        alias_method :to_s, :name
        alias_method :to_i, :level
        alias_method :last_modified, :last_update

        def initialize(elem, api = nil)
          @api = api

          @id          = elem.xpath('td[7]/a').map { |link| link['href'].split("matches/player/")[1] }.to_s
          @name        = elem.xpath('td[2]').text
          @level       = elem.xpath('td[3]').text.to_i
          @url         = elem.xpath('td[2]/a').map { |link| link['href'].split(@api.base_url)[1] }.to_s
          @region      = @api.region
          @last_update = elem.xpath('td[10]').text

        end

      end
    end
  end
end