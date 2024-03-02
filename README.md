# Ruby Web Crawling with Nokogiri

This project demonstrates how to perform web crawling on a business directory website using Ruby and Nokogiri. It extracts information such as business names, categories, descriptions, phone numbers, fax numbers, and business tags from listings, and additional details from individual business pages if available.

## Prerequisites

Before running this script, ensure you have Ruby installed on your system. Additionally, you will need the Nokogiri gem, which can be installed using the following command:

```bash
gem install nokogiri
```

## Installation

Clone this repository to your local machine:

```bash
git clone <repository-url>
```

Navigate to the project directory:

```bash
cd <project-directory>
```

## Usage

To run the script, execute the following command in the terminal:

```bash
ruby scraper.rb
```

This command will start the crawling process. The script will navigate through the web pages, extract the necessary information, and output the data to the console. Additionally, it will save the extracted data into a file named `businesses.json` in the project directory.

## Output Format

The script outputs and saves the data in JSON format. Here is an example of what the data might look like:

```json
[
  {
    "Business Name": "Example Business",
    "Category": "Services",
    "Short Description": "This is a short description of the business.",
    "Long Description": "This is a more detailed description of the business, including services offered and other relevant information.",
    "Phone Number": "123-456-7890",
    "Fax Number": "098-765-4321",
    "Business Tag": "ExampleTag",
    "Details": "Additional details about the business."
  }
  // More business listings follow...
]
```

## Disclaimer

This script is for educational purposes only. Web crawling should be done responsibly and with respect to the terms of service of the website being scraped. Always ensure that your actions comply with legal guidelines and the website's crawling policy.

## Contributing

Feel free to fork this repository and submit pull requests to contribute to this project. For major changes, please open an issue first to discuss what you would like to change.


## License
This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

![CC BY-SA 4.0](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)

**Attribution**: This project is published by Samael (AI Powered), 2024.

You are free to:
- **Share** — copy and redistribute the material in any medium or format
- **Adapt** — remix, transform, and build upon the material for any purpose, even commercially.

Under the following terms:
- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
- **ShareAlike** — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

Notices:
You do not have to comply with the license for elements of the material in the public domain or where your use is permitted by an applicable exception or limitation.

No warranties are given. The license may not give you all of the permissions necessary for your intended use. For example, other rights such as publicity, privacy, or moral rights may limit how you use the material.
