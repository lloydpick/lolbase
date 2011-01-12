# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lolbase/version"

Gem::Specification.new do |s|
  s.name        = "lolbase"
  s.version     = Lolbase::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lloyd Pick"]
  s.email       = ["lloydpick@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/lolbase"
  s.summary     = %q{Gem to access data on lolbase.net}
  s.description = %q{Gem to access data on lolbase.net}

  s.rubyforge_project = "lolbase"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
