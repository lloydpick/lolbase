$:.unshift(File.dirname(__FILE__))

Dir[File.expand_path('../site/*.rb', __FILE__)].each { |f| require f }

module Lolbase
  module Classes

    # character
    class Character          < Lolbase::Site::Character::Base; end
    class SearchCharacter    < Lolbase::Site::Character::Base; end

  end
end