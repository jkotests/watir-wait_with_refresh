require 'rspec/autorun'
require 'watir'
require '../lib/watir/wait_with_refresh'
require 'time'

RSpec.configure do |config|
  config.before(:all) do 
    # Setup the browser
    @browser = Watir::Browser.new :firefox

    # Go to the test page
    file_path = "file://#{File.expand_path("../html", __FILE__)}"
    file = 'clock.htm'
    url = File.join(file_path, file)
    @browser.goto url
  end
  
  config.before(:each) do
    @browser.refresh
  end    
  
  config.after(:all) do
    @browser.close
  end
end