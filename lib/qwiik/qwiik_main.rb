# frozen_string_literal: true

# extends module qwiik
module Qwiik
  class << self
    def generate_signature(key:, secret:)
      date = Time.now.strftime('%a, %d %b %Y %H:%M:%S EAT')
      date_to_encode = "date: #{date}"
      hmac_hash = OpenSSL::HMAC.digest('SHA256', secret, date_to_encode)
      encoded_hmac_hash = Base64.strict_encode64(hmac_hash)
      url_encoded = URI.encode_www_form_component(encoded_hmac_hash)
      %(keyId="#{key}",algorithm="hmac-sha256",signature="#{url_encoded}")
    end

    def payouts(category:, amount:, recipient_no:, reference:)
      body = if category == 'BusinessBuyGoods'
               {
                 data: {
                   type: 'payouts',
                   id: SecureRandom.uuid,
                   attributes: {
                     "category": 'BusinessBuyGoods',
                     "amount": amount,
                     "recipient_no": recipient_no,
                     "recipient_type": 'shortcode',
                     "posted_at": '2019-03-18T17:22:09.651011Z',
                     "reference": reference
                   }
                 }
               }
             elsif category == 'BusinessPayBill'
               {
                 data: {
                   type: 'payouts',
                   id: SecureRandom.uuid,
                   attributes: {
                     category: category,
                     amount: amount,
                     recipient_no: recipient_no,
                     recipient_type: 'shortcode',
                     posted_at: '2019-03-18T17:22:09.651011Z',
                     recipient_id_type: 'national_id',
                     recipient_id_number: '21212121',
                     reference: reference
                   }
                 }
               }
             else
               {
                 data: {
                   type: 'payouts',
                   id: SecureRandom.uuid,
                   attributes: {
                     category: category,
                     amount: amount,
                     recipient_no: recipient_no,
                     recipient_type: 'msisdn',
                     posted_at: '2019-03-18T17:22:09.651011Z',
                     recipient_id_type: 'national_id',
                     recipient_id_number: '12345567',
                     reference: reference
                   }
                 }
               }
             end
      # make the request
      call(path: '/mpesa/payouts', body: body.to_json)
    end

    def call(path:, body:)
      headers = {
        'accept' => 'application/vnd.api+json',
        'Content-Type' => 'application/vnd.api+json',
        'Authorization' => generate_signature(key: ENV['QWIIK_PAYOUT_KEY'], secret: ENV['QWIIK_PAYOUT_SECRET']),
        'Date' => Time.now.strftime('%a, %d %b %Y %H:%M:%S EAT')
      }
      base_url = Qwiik.configuration.base_url
      Faraday.post(base_url + path, body, headers)
    end
end
end
