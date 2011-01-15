require 'fileutils'

begin
  require 'bundler'
rescue LoadError
  require 'rubygems'
  require 'bundler'
end
Bundler.require

require 'core_ext/class'
require 'httparty/icebox'

require 'lolbase/api'
require 'lolbase/exceptions'