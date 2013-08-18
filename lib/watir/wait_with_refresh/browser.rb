# encoding: utf-8
module Watir
  class Browser
    
    def refresh_until(*args, &blk)
      Watir::WaitWithRefresh.refresh_until(browser, *args, &blk)
    end

    def refresh_while(*args, &blk)
      Watir::WaitWithRefresh.refresh_while(browser, *args, &blk)
    end

  end # Browser
end # Watir