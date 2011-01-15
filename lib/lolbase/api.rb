module Lolbase
  module API
    autoload :API,    'lolbase/api/api'
    autoload :Client, 'lolbase/api/client'

    autoload :Characters, 'lolbase/api/characters'

    # Returns a new instance of Lolbase::API::API
    def self.new(options = {})
      # This is basically a hack to let us have a namespace called API without
      # breaking old code which calls API.new(...)
      API.new(options)
    end
  end
end