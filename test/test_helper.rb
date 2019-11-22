# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'
SimpleCov.start
require 'qwiik'

require 'minitest/autorun'
require 'faraday'
require 'webmock/minitest'
require 'vcr'
require 'openssl'
require 'uri'
require 'securerandom'
require 'simplecov'
require 'minitest/reporters'
require 'coveralls'

# coverage
Coveralls.wear!

# minitest reporters
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# SimpleCov.start 'rails'

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
  yaml_fixtures = Dir[File.expand_path('fixtures/**/*.y*ml', __dir__)].map do |f|
    erb_yaml = ERB.new(File.read(f))
    YAML.safe_load(erb_yaml.result)
  end.inject(:merge)

  FIXTURES = yaml_fixtures.freeze
  def setup
    # configure our gem
    Qwiik.configure do |config|
      config.confirmation_url = 'https://example.com/confirm'
      config.validation_url = 'https://example.com/validate'
      config.key = ENV['QWIIK_PAYOUT_KEY']
      config.secret = ENV['QWIIK_PAYOUT_SECRET']
    end

    # default headers
    @key = ENV['QWIIK_PAYOUT_KEY']
    @secret = ENV['QWIIK_PAYOUT_SECRET']
    @headers = {
      'accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json',
      'Authorization' => Qwiik.generate_signature(key: @key, secret: @secret),
      'Date' => Time.now.strftime('%a, %d %b %Y %H:%M:%S EAT')
    }
    # default test url
    @base_url = 'https://api-staging.qwwik.com'
  end
end
