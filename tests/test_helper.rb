# frozen_string_literal: true

# tests/test_helper.rb
require 'vcr'
require 'webmock'
require 'test/unit'
require 'mocha/test_unit' # If you're using mocks or stubs

WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.cassette_library_dir = 'tests/vcr_cassettes'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.debug_logger = $stdout
end

# # Helper method to generate names for your VCR cassettes
# def vcr_test_name(name)
#   name.downcase.gsub(/\s+/, '_').gsub(%r{[^\w/]+}, '_').gsub(%r{/$}, '')
# end
