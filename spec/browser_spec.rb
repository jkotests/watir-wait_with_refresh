require_relative 'spec_helper.rb'

describe "Browser" do
  describe "#refresh_until" do
    it "refresh page until the block evaluates to true" do
      start_time = @browser.div(:id => 'clock').text
      expected_end = Time.parse(start_time) + 10
      expected_text = expected_end.strftime('%H:%M:%S')[0..-2]

      lambda{
        @browser.refresh_until(15) do
          @browser.div(:text => /^#{expected_text}/).present?
        end
      }.should_not raise_exception
      @browser.div(:text => /^#{expected_text}/).should exist
    end
    
    it "raise timeout error when block never evaluates to true" do
      expected_text = '99:99:9'

      lambda{ 
        @browser.refresh_until(15) do 
          false
        end
      }.should raise_exception Watir::WaitWithRefresh::TimeoutError
    end
    
    it "not refresh when the block already evaluates to true" do
      start_time = @browser.div(:id => 'clock').text
      sleep(1)
      @browser.refresh_until do
        @browser.div(:id => 'clock').present?
      end		
      @browser.div(:id => 'clock').text.should == start_time
    end	
  end

  describe "#refresh_while" do
    it "refresh page while the block evaluates to true" do
      start_time = @browser.div(:id => 'clock').text
      start_text = Time.parse(start_time).strftime('%H:%M:%S')[0..-2]

      lambda{ 
        @browser.refresh_while(15) do
          @browser.div(:text => /^#{start_text}/).present?
        end
      }.should_not raise_exception
      @browser.div(:text => /^#{start_text}/).should_not exist
    end
    
    it "raise timeout error when block never evaluates to false" do
      lambda{ 
        @browser.refresh_while(5) do
          true
        end
      }.should raise_exception Watir::WaitWithRefresh::TimeoutError
    end
    
    it "not refresh when the block already evaluates to false" do
      start_time = @browser.div(:id => 'clock').text
      sleep(1)
      @browser.refresh_while do
        @browser.div(:id => 'non_existent_id').present?
      end		
      @browser.div(:id => 'clock').text.should == start_time
    end	
  end
end