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

        attr_reader :normal_wins
        attr_reader :normal_wins_real
        attr_reader :normal_losses
        attr_reader :normal_losses_real
        attr_reader :normal_leaves
        attr_reader :normal_leaves_real

        attr_reader :ranked_wins
        attr_reader :ranked_wins_real
        attr_reader :ranked_losses
        attr_reader :ranked_losses_real
        attr_reader :ranked_leaves
        attr_reader :ranked_leaves_real

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

          @normal_wins        = elem.xpath('td[4]').text.scan(/(\d*)\/\d* \(\d*\/\d*\)/).to_s.to_i
          @normal_wins_real   = elem.xpath('td[4]').text.scan(/\d*\/\d* \((\d*)\/\d*\)/).to_s.to_i
          @normal_losses      = elem.xpath('td[5]').text.scan(/(\d*)\/\d* \(\d*\/\d*\)/).to_s.to_i
          @normal_losses_real = elem.xpath('td[5]').text.scan(/\d*\/\d* \((\d*)\/\d*\)/).to_s.to_i
          @normal_leaves      = elem.xpath('td[6]').text.scan(/(\d*)\/\d* \(\d*\/\d*\)/).to_s.to_i
          @normal_leaves_real = elem.xpath('td[6]').text.scan(/\d*\/\d* \((\d*)\/\d*\)/).to_s.to_i

          @ranked_wins        = elem.xpath('td[4]').text.scan(/\d*\/(\d*) \(\d*\/\d*\)/).to_s.to_i
          @ranked_wins_real   = elem.xpath('td[4]').text.scan(/\d*\/\d* \(\d*\/(\d*)\)/).to_s.to_i
          @ranked_losses      = elem.xpath('td[5]').text.scan(/\d*\/(\d*) \(\d*\/\d*\)/).to_s.to_i
          @ranked_losses_real = elem.xpath('td[5]').text.scan(/\d*\/\d* \(\d*\/(\d*)\)/).to_s.to_i
          @ranked_leaves      = elem.xpath('td[6]').text.scan(/\d*\/(\d*) \(\d*\/\d*\)/).to_s.to_i
          @ranked_leaves_real = elem.xpath('td[6]').text.scan(/\d*\/\d* \(\d*\/(\d*)\)/).to_s.to_i

        end

      end
    end
  end
end