require File.dirname(__FILE__) + '/../test_helper'

class TimeLoggerTest < ActiveSupport::TestCase
  self.fixture_path = File.expand_path('../fixtures', __dir__)
  
  fixtures :time_loggers

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
