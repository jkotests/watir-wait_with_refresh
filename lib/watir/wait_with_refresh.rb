module Watir
  module WaitWithRefresh
  
    #
    # Due to the difference in implementation between watir-classic
    # and watir-webdriver, the browser class is different - "Browser"
    # vs "IE". Monkey patch based on the gem loaded.
    #
  
    def self.load()
      if Gem.loaded_specs.keys.include?('watir-classic')
        require_relative 'wait_with_refresh/ie'
      elsif Gem.loaded_specs.keys.include?('watir-webdriver')
        require_relative 'wait_with_refresh/browser'
      else
        raise LoadError, "Watir must be required before Watir::WaitWithRefresh"        
      end
        require_relative 'wait_with_refresh/wait'      
        require_relative 'wait_with_refresh/element'
    end
  end
end


if Gem.loaded_specs.keys.include?('watir')
  # Watir was loaded. Override Watir.load_driver to include 
  # WaitWithRefresh based on the watir driver loaded.
  module Watir
    class << self
      def load_driver
        require "watir-#{driver}"
        Watir::WaitWithRefresh.load
      end
    end # self
  end # Watir

else
  # Watir-classic or watir-webdriver was directly loaded.
  # Therefore, we can already determine the class to monkey patch.
  Watir::WaitWithRefresh.load

end

