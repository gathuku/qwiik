# frozen_string_literal: true

require 'test_helper'

class QwiikTest < Minitest::Test
  def setup
    Qwiik.configure do |config|
      config.confirmation_url = 'https://example.com/confirm'
      config.validation_url = 'https://example.com/validate'
    end
    @headers = {
      'accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
    @url = 'https://api-staging.qwiik.com'
  end

  def test_it_can_configure
    assert_equal Qwiik.configuration.confirmation_url, 'https://example.com/confirm'
    assert_equal Qwiik.configuration.validation_url, 'https://example.com/validate'
 end

  def test_it_registers_ulrls
    body = {
      data: {
        type: 'urls',
        id: 1,
        attributes: {
          confirmation_url: 'https://example.com/confirm',
          validation_url: 'https://example.com/validate',
          short_code: '600234',
          response_type: 'Completed'
        }
      }
    }
    stub_request(:post, @url)
      .with(
        body: body.to_json,
        headers: @headers
      )
      .to_return(status: 200, body: '', headers: {})

    assert_equal 200, Qwiik::QwiikMain.register_urls('Completed').status
  end

  def test_payouts
    body = {
      data: {
        type: 'payouts',
        id: 1,
        attributes: {
          category: 'BusinessPayment',
          amount: 1000,
          recipient_no: '25472264885',
          recipient_type: 'msisdn',
          posted_at: Time.now,
          recipient_id_type: 'national_id',
          recipient_id_number: '12345567',
          reference: '142345654'
        }
      }
    }

    stub_request(:post, @url)
      .with(body: body.to_json, headers: @headers)
      .to_return(status: 200, body: '', headers: {})
    assert_equal 200, Qwiik::QwiikMain.payouts('BusinessPayment', 1000, '25472264885', '142345654').status
  end
end
