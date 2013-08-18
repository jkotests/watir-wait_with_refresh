# encoding: utf-8
module Watir
  class Element
    
    #
    # Refresh the page until the element is present.
    #
    # @example
    #   browser.button(:id => 'foo').refresh_until_present
    #
    # @param [Fixnum] timeout seconds to wait before timing out
    #
    # @see Watir::WaitWithRefresh
    # @see Watir::Element#present?
    #

    def refresh_until_present(timeout = 30)
      message = "waiting for #{@selector.inspect} to become present"
      Watir::WaitWithRefresh.refresh_until(browser, timeout, message) { present? }
    end

    #
    # Refresh the page while the element is present.
    #
    # @example
    #   browser.button(:id => 'foo').refresh_while_present
    #
    # @param [Integer] timeout seconds to wait before timing out
    #
    # @see Watir::WaitWithRefresh
    # @see Watir::Element#present?
    #

    def refresh_while_present(timeout = 30)
      message = "waiting for #{@selector.inspect} to disappear"
      Watir::WaitWithRefresh.refresh_while(browser, timeout, message) { present? }
    end

  end # Element
end # Watir