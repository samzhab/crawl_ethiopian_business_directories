# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
require 'json'

class Crawl
  attr_reader :crawl_url # This line adds a method to read @weregna_url

  # Initialize the crawler with base URL
  def initialize(crawl_url)
    @crawl_url = crawl_url
  end

  # Function to sanitize text
  def sanitize_text(text)
    return text.gsub(/\s+/, ' ').strip if text

    ''
  end

  # Function to extract and assign business details from text using regex
  def extract_details(details_text)
    # Define a hash to store the extracted details
    extracted_details = {}

    # Regular expressions for each field
    regex_map = {
      'Business Name' => /Business Name:\s*(.*?)\s*Business Genre:/m,
      'Category' => /Business Genre:\s*(.*?)\s*Business Description:/m,
      'Short Description' => /Business Description:\s*(.*?)\s*Long Business Description:/m,
      'Long Description' => /Long Business Description:\s*(.*?)\s*Business Phone Number:/m,
      'Phone Number' => /Business Phone Number:\s*(.*?)\s*Business Fax:/m,
      'Fax Number' => /Business Fax:\s*(.*?)\s*Business Tags:/m,
      'Business Tag' => /Business Tags:\s*(.*)$/m
    }

    # Extract details using the defined regex
    regex_map.each do |key, regex|
      match = details_text.match(regex)
      extracted_details[key] = match ? sanitize_text(match[1]) : ''
    end

    # Format the phone number if it exists
    extracted_details['Phone Number']&.gsub!(/\s+/, '-')

    # Return the extracted details
    extracted_details
  end

  # Method to scrape the events listings
  def crawl_events
    # Implement your logic to crawl events
    # For now, let's just return a placeholder array
    []
  end

  # Method to scrape the business listings
  def crawl_businesses
    # Use HTTParty to get the page content
    response = HTTParty.get(@crawl_url.to_s)
    listings_doc = Nokogiri::HTML(response.body)

    businesses = []

    # Iterate through each business listing using CSS selectors
    listings_doc.css('[id^="wpbdp-listing-"]').each do |listing|
      details_text = listing.text # Get the full text from each listing

      # Extract and assign business details from the text
      business = extract_details(details_text)

      businesses << business
    end

    businesses
  end

  # Method to run both crawling methods and save data to JSON files
  def run
    events = crawl_events
    businesses = crawl_businesses

    # Save events to JSON file
    File.open('events.json', 'w') do |file|
      file.write(events.to_json)
    end

    # Save businesses to JSON file
    File.open('businesses.json', 'w') do |file|
      file.write(businesses.to_json)
    end

    { events: events, businesses: businesses }
  end
end

# Usage
weregna_url = 'http://www.weregna.com/ethiopia-ethiopian-yellow-pages/?wpbdp_view=all_listings'
crawler = Crawl.new(weregna_url)
crawler.run
