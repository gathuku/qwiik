# frozen_string_literal: true

require 'test_helper'

class QwiikTest < Minitest::Test
  def test_it_can_configure
    assert_equal Qwiik.configuration.confirmation_url, 'https://example.com/confirm'
    assert_equal Qwiik.configuration.validation_url, 'https://example.com/validate'
 end

  def test_it_registers_url
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
    VCR.use_cassette('register_urls') do
      res = Faraday.post(@base_url + '/mpesa/urls', body.to_json, @headers)
      assert_equal(200, res.status)
    end
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

    VCR.use_cassette('payouts') do
      res = Faraday.post(@base_url + '/mpesa/payouts', body.to_json, @headers)
      assert_equal(200, res.status)
    end
  end
end
