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

    #
    # Refreshes the page until the element is present.
    #
    # @example
    #   browser.button(:id => 'foo').when_present_after_refresh.click
    #   browser.div(:id => 'bar').when_present_after_refresh { |div| ... }
    #   browser.p(:id => 'baz').when_present_after_refresh(60).text
    #
    # @param [Fixnum] timeout seconds to wait before timing out
    #
    # @see Watir::WaitWithRefresh
    # @see Watir::Element#present?
    #

    def when_present_after_refresh(timeout = 30)
      message = "waiting for #{@selector.inspect} to become present"

      if block_given?
        Watir::WaitWithRefresh.refresh_until(browser, timeout, message) { present? }
        yield self
      else
        WhenPresentAfterRefreshDecorator.new(self, timeout, message)
      end
    end

  end # Element
  
  #
  # Wraps an Element so that any subsequent method calls are
  # put on hold until the element is present (exists and is visible) on the page.
  #

  class WhenPresentAfterRefreshDecorator
    def initialize(element, timeout, message = nil)
      @element = element
      @timeout = timeout
      @message = message
    end

    def respond_to?(*args)
      @element.respond_to?(*args)
    end

    def method_missing(m, *args, &block)
      unless @element.respond_to?(m)
        raise NoMethodError, "undefined method `#{m}' for #{@element.inspect}:#{@element.class}"
      end

      Watir::WaitWithRefresh.refresh_until(@element.browser, @timeout, @message) { @element.present? }

      @element.__send__(m, *args, &block)
    end
  end # WhenPresentAfterRefreshDecorator  
end # Watir