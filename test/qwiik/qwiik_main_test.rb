# frozen_string_literal: true

require 'test_helper'

class QwiikMainTest < Minitest::Test
  def test_payouts_to_customers
    body = {
      data: {
        type: 'payouts',
        id: SecureRandom.uuid,
        attributes: {
          "category": 'BusinessPayment',
          "amount": 100,
          "recipient_no": '0722000024',
          "recipient_type": 'msisdn',
          "posted_at": '2019-03-18T17:22:09.651011Z',
          "recipient_id_type": 'national_id',
          "recipient_id_number": '21212121',
          "reference": '12345678'
        }
      }
    }

    VCR.use_cassette('payouts_customer') do
      res = Faraday.post(@base_url + '/mpesa/payouts', body.to_json, @headers)
      assert_equal(200, res.status)
    end
  end

  # Business paybill payouts_
  def test_payouts_to_business_paybill
    body = {
      data: {
        type: 'payouts',
        id: SecureRandom.uuid,
        attributes: {
          "category": 'BusinessPayBill',
          "amount": 1000,
          "recipient_no": '601000',
          "recipient_type": 'shortcode',
          "posted_at": '2019-03-18T17:22:09.651011Z',
          "recipient_id_type": 'national_id',
          "recipient_id_number": '21212121',
          "reference": '7000'
        }
      }
    }

    VCR.use_cassette('payouts_business_paybill') do
      res = Faraday.post(@base_url + '/mpesa/payouts', body.to_json, @headers)
      assert_equal(200, res.status)
    end
  end

  # business buy goods payouts_
  def test_payouts_to_business_buy_goods
    body = {
      data: {
        type: 'payouts',
        id: SecureRandom.uuid,
        attributes: {
          "category": 'BusinessBuyGoods',
          "amount": 1000,
          "recipient_no": '116261',
          "recipient_type": 'shortcode',
          "posted_at": '2019-03-18T17:22:09.651011Z',
          "reference": '7000'
        }
      }
    }

    VCR.use_cassette('payouts_business_till') do
      res = Faraday.post(@base_url + '/mpesa/payouts', body.to_json, @headers)
      assert_equal(200, res.status)
    end
  end
end
