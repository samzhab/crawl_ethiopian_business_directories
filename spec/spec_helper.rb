# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

class String
  def underscore
    downcase.gsub(/\s+/, '_').gsub(%r{[^\w/]+}, '_').gsub(%r{/$}, '')
  end
end

# WebMock.disable!

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  # config.ignore_localhost = true
  # Other configurations...
  config.debug_logger = $stdout
end

RSpec.configure do |config|
  config.around(:each, vcr: true) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.tr(' ', '_').gsub(%r{[^\w/]+}, '_').gsub(
      %r{/$}, ''
    )
    VCR.use_cassette(name) do
      example.run
    end
  end
end
