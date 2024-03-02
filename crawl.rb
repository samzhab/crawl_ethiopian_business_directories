require 'httparty'
require 'nokogiri'
require 'json'
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

  extracted_details
end

# Base URL of the website
base_url = 'http://www.weregna.com/ethiopia-ethiopian-yellow-pages/'

# Use HTTParty to get the page content
response = HTTParty.get("#{base_url}?wpbdp_view=all_listings")
listings_doc = Nokogiri::HTML(response.body)

businesses = []

# Iterate through each business listing using CSS selectors
listings_doc.css('[id^="wpbdp-listing-"]').each do |listing|
  details_text = listing.text # Get the full text from each listing

  # Extract and assign business details from the text
  business = extract_details(details_text)

  businesses << business
end

# Output to console
puts businesses
# Save to JSON file
File.open('businesses.json', 'w') do |file|
  file.write(businesses.to_json)
end
