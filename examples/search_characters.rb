$:.unshift(File.expand_path('../../lib', __FILE__))
require 'lolbase'

api = Lolbase::API.new(:caching => false)
characters = api.search_characters('Aaru')
puts characters.to_yaml