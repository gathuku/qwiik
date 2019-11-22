# frozen_string_literal: true

require 'test_helper'

class QwiikMainTest < Minitest::Test
  # Business customer payouts
  def test_payouts_to_customers
    VCR.use_cassette('payouts_customer') do
      body = FIXTURES['customer'].to_json
      res = Faraday.post(@base_url + '/mpesa/payouts', body, @headers)
      assert_equal(200, res.status)
    end
  end

  # Business paybill payouts_
  def test_payouts_to_business_paybill
    body = FIXTURES['paybill'].to_json
    VCR.use_cassette('payouts_business_paybill') do
      res = Faraday.post(@base_url + '/mpesa/payouts', body, @headers)
      assert_equal(200, res.status)
    end
  end

  # business buy goods payouts_
  def test_payouts_to_business_buy_goods
    body = FIXTURES['till'].to_json
    VCR.use_cassette('payouts_business_till') do
      res = Faraday.post(@base_url + '/mpesa/payouts', body, @headers)
      assert_equal(200, res.status)
    end
  end

  # Hash generate
  def test_it_generate_signature
    refute_nil Qwiik.generate_signature(key: @key, secret: @secret)
    refute_nil Time.now.strftime('%a, %d %b %Y %H:%M:%S EAT')
  end
end
