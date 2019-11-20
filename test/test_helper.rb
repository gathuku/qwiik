# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'qwiik'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

# configure vcr
VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = false
  config.cassette_library_dir = File.expand_path('cassettes', __dir__)
  config.hook_into :webmock
  config.ignore_request { ENV['DISABLE_VCR'] }
  config.ignore_localhost = true
  config.default_cassette_options = {
    record: :new_episodes
  }
end

# default class
class Minitest::Test
  def setup
    # configure our gem
    Qwiik.configure do |config|
      config.confirmation_url = 'https://example.com/confirm'
      config.validation_url = 'https://example.com/validate'
    end
    # default headers
    @headers = {
      'accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
    # default test url
    @base_url = 'https://api-staging.qwwik.com'
  end
end
