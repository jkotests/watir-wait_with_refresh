# encoding: utf-8
module Watir
  module WaitWithRefresh
  
    class TimeoutError < StandardError ; end

    INTERVAL = 0.1

    class << self
      
      #
      # Refresh the browser until the block evaluates to true or times out.
      #
      # @example
      #   Watir::WaitWithRefresh.refresh_until(browser){ browser.a(:id => "ajaxed").visible? }
      #
      # @param [Watir::Browser] browser
      # @param [Fixnum] timeout How long to wait in seconds
      # @param [String] message Message to raise if timeout is exceeded
      # @raise [TimeoutError] if timeout is exceeded
      #

      def refresh_until(browser, timeout = 30, message = nil, &block)
        end_time = ::Time.now + timeout

        until ::Time.now > end_time
          result = yield(self)
          return result if result
          sleep INTERVAL
          browser.refresh
        end

        raise TimeoutError, message_for(timeout, message)
      end

      #
      # Refresh the browser while the block evaluates to true or times out.
      #
      # @example
      #   Watir::WaitWithRefresh.refresh(browser){ browser.a(:id => "ajaxed").visible? }
      #
      # @param [Watir::Browser] browser
      # @param [Fixnum] timeout How long to wait in seconds
      # @param [String] message Message to raise if timeout is exceeded
      # @raise [TimeoutError] if timeout is exceeded
      #

      def refresh_while(browser, timeout = 30, message = nil, &block)
        end_time = ::Time.now + timeout

        until ::Time.now > end_time
          return unless yield(self)
          sleep INTERVAL
          browser.refresh
        end

        raise TimeoutError, message_for(timeout, message)
      end

      def message_for(timeout, message)
        err = "timed out after #{timeout} seconds"
        err << ", #{message}" if message

        err
      end

    end #self
  end # WaitWithRefresh
end # Watir