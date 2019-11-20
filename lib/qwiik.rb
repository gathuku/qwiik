# frozen_string_literal: true

require 'qwiik/version'
require 'qwiik/qwiik_main'
require 'faraday'

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

class Configuration
  attr_accessor :confirmation_url, :validation_url, :short_code, :env

  def initialize
    @confirmation_url = 'https://example.com/confirmation'
    @validation_url = 'https://example.com/validation'
    @short_code = '600234'
    @env = 'sandbox'
  end
end
