require_relative 'spec_helper.rb'

describe "Element" do
  describe "#refresh_until_present" do
    it "refresh page until an element is present" do
      start_time = @browser.div(:id => 'clock').text
      expected_end = Time.parse(start_time) + 10
      expected_text = expected_end.strftime('%H:%M:%S')[0..-2]

      lambda{
        @browser.div(:text => /^#{expected_text}/).refresh_until_present(15)
      }.should_not raise_exception
      @browser.div(:text => /^#{expected_text}/).should exist
    end
    
    it "raise timeout error when element does not exist" do
      expected_text = '99:99:9'

      lambda{
        @browser.div(:text => /^#{expected_text}/).refresh_until_present(5)
      }.should raise_exception Watir::WaitWithRefresh::TimeoutError
    end

    it "not refresh when the element is already present" do
      start_time = @browser.div(:id => 'clock').text
      sleep(1)
      @browser.div(:id => 'clock').refresh_until_present
      @browser.div(:id => 'clock').text.should == start_time
    end
  end

  describe "#refresh_while_present" do
    it "refresh page while an element is present" do
      start_time = @browser.div(:id => 'clock').text
      start_text = Time.parse(start_time).strftime('%H:%M:%S')[0..-2]

      lambda{
        @browser.div(:text => /^#{start_text}/).refresh_while_present(15)
      }.should_not raise_exception
      @browser.div(:text => /^#{start_text}/).should_not exist
    end
    
    it "raise timeout error when element continues to exist" do
      lambda{ 
        @browser.div.refresh_while_present(5)
      }.should raise_exception Watir::WaitWithRefresh::TimeoutError
    end
    
    it "not refresh when the element does not exist" do
      start_time = @browser.div(:id => 'clock').text
      sleep(1)
      @browser.div(:id => 'non_existent_id').refresh_while_present		
      @browser.div(:id => 'clock').text.should == start_time
    end	
  end
end