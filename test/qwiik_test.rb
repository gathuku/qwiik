# frozen_string_literal: true

require 'test_helper'

class QwiikTest < Minitest::Test
  def test_it_can_configure
    assert_equal Qwiik.configuration.confirmation_url, 'https://example.com/confirm'
    assert_equal Qwiik.configuration.validation_url, 'https://example.com/validate'
  end
end
