# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "watir/wait_with_refresh/version"

Gem::Specification.new do |s|
  s.name        = "watir-wait_with_refresh"
  s.version     = Watir::WaitWithRefresh::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Ko"]
  s.email = 'jkotests@gmail.com'
  s.homepage    = "https://github.com/jkotests/watir-wait_with_refresh"
  s.summary     = %q{Extend Watir to wait with page refreshes.}
  s.description = %q{Extend Watir to wait with page refreshes.}
  
  s.files = Dir["{lib}/**/*.rb", "LICENSE", "*.md"]
  s.require_path = "lib"
  
  s.add_dependency "watir"
end
