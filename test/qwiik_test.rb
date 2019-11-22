# frozen_string_literal: true

require 'test_helper'

class QwiikTest < Minitest::Test
  def test_it_can_configure
    assert_equal Qwiik.configuration.confirmation_url, 'https://example.com/confirm'
    assert_equal Qwiik.configuration.validation_url, 'https://example.com/validate'
  end

  def test_it_can_reset_configuration
    assert Qwiik.respond_to?(:reset)
  end

  def if_configured
    refute_nil Qwiik.configuration.base_url
    refute_nil ENV['QWIIK_PAYOUT_KEY']
    refute_nil ENV['QWIIK_PAYOUT_SECRET']
  end
end
