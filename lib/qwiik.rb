# frozen_string_literal: true

require 'qwiik/version'
require 'qwiik/qwiik_main'
require 'faraday'
require 'uri'
require 'openssl'
require 'securerandom'
require 'json'
require 'base64'
# module qwwik
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
end
# class configuration
class Configuration
  attr_accessor :confirmation_url, :validation_url,
                :short_code, :env, :key, :secret, :base_url

  def initialize
    @confirmation_url = 'https://example.com/confirmation'
    @validation_url = 'https://example.com/validation'
    @short_code = '600234'
    @env = 'sandbox'
    @base_url = 'https://api-staging.qwwik.com'
  end
end
