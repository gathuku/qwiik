# frozen_string_literal: true

module Qwiik
  module QwiikMain
    def self.set_url
      if Qwiik.configuration.env == 'sandbox'
        'https://api-staging.qwiik.com'
      else
        'https://api.qwiik.com'
     end
    end

    def self.register_urls(response_type)
      headers = {
        'accept' => 'application/vnd.api+json',
        'Content-Type' => 'application/vnd.api+json'
      }
      body = {
        data: {
          type: 'urls',
          id: 1,
          attributes: {
            confirmation_url: Qwiik.configuration.confirmation_url,
            validation_url: Qwiik.configuration.validation_url,
            short_code: Qwiik.configuration.short_code,
            response_type: response_type
          }
        }
      }

      Faraday.post(set_url, body.to_json, headers)
       end

    def self.payouts(category, amount, recipient_no, reference)
      url = 'https://virtserver.swaggerhub.com/zegetech/mpesaUniAPI/1.0/mpesa/payouts'
      headers = {
        'accept' => 'application/vnd.api+json',
        'Content-Type' => 'application/vnd.api+json'
      }
      body = {
        data: {
          type: 'payouts',
          id: 1,
          attributes: {
            category: category,
            amount: amount,
            recipient_no: recipient_no,
            recipient_type: 'msisdn',
            posted_at: Time.now,
            recipient_id_type: 'national_id',
            recipient_id_number: '12345567',
            reference: reference
          }
        }
      }
      Faraday.post(url, body.to_json, headers)
    end
end
end
