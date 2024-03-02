# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

require_relative '../crawl' # Adjust the path based on your file structure
require_relative 'spec_helper' # Adjust the path based on your file structure
describe Crawler do
  crawl_url = 'http://www.weregna.com/ethiopia-ethiopian-yellow-pages/'
  context 'when fetching and processing listing data' do
    it 'makes an HTTP request to the correct URL' do
      # Assuming you have a method in Crawler that returns the final URL
      crawler = Crawler.new(crawl_url)
      expect(crawler.base_url).to eq(crawl_url)
    end

    it 'makes an HTTP request and records the response', :vcr do
      crawler = Crawler.new(crawl_url)
      response = crawler.crawl_businesses # This should be the actual method that makes the HTTP request
      expect(response).not_to be_nil
      # Add more expectations here as needed
    end

    it 'completes the scraping process without errors', :vcr do
      # The :vcr symbol tells VCR to record or replay interactions for this example
      crawler = Crawler.new(crawl_url) # Assuming your crawler setup does not require arguments
      expect { crawler.crawl_businesses }.not_to raise_error
    end

    it 'returns an array of businesses', :vcr do
      crawler = Crawler.new(crawl_url)
      result = crawler.crawl_businesses
      expect(result).to be_a(Array)
      expect(result.first).to be_a(Hash)
      expect(result.first.keys).to contain_exactly('Business Name', 'Category', 'Short Description',
                                                   'Long Description', 'Phone Number', 'Fax Number', 'Business Tag')
    end

    it 'extracts correct information for each business', :vcr do
      crawler = Crawler.new(crawl_url)
      result = crawler.crawl_businesses
      first_business = result.first
      # Add assertions based on expected data, for example:
      expect(first_business['Business Name']).not_to be_empty
      expect(first_business['Phone Number']).to match(/\A\d{3}-\d{3}-\d{4}\z/) # Example format
      # Add more checks as necessary for your data
    end
  end
end
