# frozen_string_literal: true

require 'test/unit'
require 'vcr'
require 'webmock'
require 'mocha/test_unit'
require_relative 'test_helper'
require_relative '../crawl' # Adjust this path if your file structure is different

class CrawlTest < Test::Unit::TestCase
  def setup
    @crawl_url = 'http://www.weregna.com/ethiopia-ethiopian-yellow-pages/'
    @crawler = Crawl.new(@crawl_url)
    VCR.use_cassette('crawl_business_listings') do
      @response = @crawler.crawl_businesses
    end
  end

  def test_http_request_and_response
    assert_not_nil @response, 'Response should not be nil'
  end

  def test_response_is_array_of_businesses
    assert_kind_of Array, @response, 'Response should be an array'
    assert_not_nil @response.first, 'Response array should not be empty'
    assert_kind_of Hash, @response.first, 'First element of the response should be a hash'
  end

  def test_first_business_data_structure
    first_business = @response.first
    assert_false first_business['Business Name'].empty?, 'Business Name should not be empty'
    assert_match(/\A\d{3}-\d{3}-\d{4}\z/, first_business['Phone Number'], 'Phone Number should match the pattern')
    # Add more checks as necessary
  end

  # Add more tests as needed, using @response for the data
end
