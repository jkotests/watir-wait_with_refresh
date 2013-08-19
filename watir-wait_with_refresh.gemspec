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
  s.description = %q{Watir::WaitWithRefresh extends Watir to include methods that will refresh the page until or while an element is present or a block is true. Adds Element#refresh_until_present, Element#refresh_while_present, Element#when_present_after_refresh, Browser#refresh_until and Browser#refresh_while.}
  
  s.files = Dir["{lib}/**/*.rb", "LICENSE", "*.md"]
  s.require_path = "lib"
  
  s.add_dependency "watir"
end
