require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Profile.new.valid?
  end
end
