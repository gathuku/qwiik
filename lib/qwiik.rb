require "qwiik/version"

module Qwiik
  class Error < StandardError; end
  # Your code goes here...
  class << self
  attr_accessor :configuration
    def configure
    self.configuration ||= Configuration.new
    yield(configuration)
    end

  def reset
    self.configuration = Configuration.new
  end
  end

  def self.register_urls(response_type)
    url="https://virtserver.swaggerhub.com/zegetech/mpesaUniAPI/1.0/mpesa/urls"
    headers={
      "accept"=>"application/vnd.api+json",
      "Content-Type"=>"application/vnd.api+json"
    }
    body={
      data:{
        type:"urls",
        id:1,
        attributes:{
          confirmation_url: Configuration.new.confirmation_url,
          validation_url: Configuration.new.validation_url,
          short_code: Configuration.new.short_code,
          response_type: response_type
        }
      }
    }
    binding.pry
    Faraday.post(url,body.to_json,headers)
  end

  def self.payouts(category,amount,recipient_no,reference)
    url="https://virtserver.swaggerhub.com/zegetech/mpesaUniAPI/1.0/mpesa/payouts"
    headers={
      "accept"=>"application/vnd.api+json",
      "Content-Type"=>"application/vnd.api+json"
    }
    body={
      data:{
        type:"payouts",
        id:1,
        attributes: {
          category: category,
          amount: amount,
          recipient_no: recipient_no,
          recipient_type: "msisdn",
          posted_at: Time.now,
          recipient_id_type: "national_id",
          recipient_id_number: "12345567",
          reference: reference
        }
      }
    }
    Faraday.post(url,body.to_json,headers)
  end

end

class Configuration
  attr_accessor :confirmation_url, :validation_url, :short_code

  def initialize
    @confirmation_url = "https://example.com/confirmation"
    @validation_url = "https://example.com/validation"
    @short_code = "600234"
  end
end
