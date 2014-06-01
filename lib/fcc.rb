require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'geocoder'

module Fcc
  STATES = {
    "Alaska" => 1,
    "Alabama" => 2,
    "Arkansas" => 3,
    "Arizona" => 4,
    "California" => 5,
    "Colorado" => 6,
    "Connecticut" => 7,
    "District of Columbia" => 8,
    "Delaware" => 9,
    "Florida" => 10,
    "Georgia" => 11,
    "Guam" => 12,
    "Hawaii" => 13,
    "Iowa" => 14,
    "Idaho" => 15,
    "Illinois" => 16,
    "Indiana" => 17,
    "Kansas" => 18,
    "Kentucky" => 19,
    "Louisiana" => 20,
    "Massachusetts" => 21,
    "Maryland" => 22,
    "Maine" => 24,
    "Michigan" => 25,
    "Minnesota" => 26,
    "Missouri" => 27,
    "Mississippi" => 28,
    "Montana" => 29,
    "North Carolina" => 30,
    "North Dakota" => 31,
    "Nebraska" => 32,
    "New Hampsire" => 33,
    "New Jersey" => 34,
    "New Mexico" => 35,
    "Nevada" => 36,
    "New York" => 37,
    "Ohio" => 38,
    "Oklahoma" => 39,
    "Oregon" => 40,
    "Pennsylvania" => 41,
    "Puerto Rico" => 42,
    "Rhode Island" => 43,
    "South Carolina" => 44,
    "South Dakota" => 45,
    "Tennessee" => 46,
    "Texas" => 47,
    "Utah" => 48,
    "Virginia" => 49,
    "Virgin Islands" => 51,
    "Vermont" => 52,
    "Washington" => 53,
    "Wisconsin" => 54,
    "West Virginia" => 55,
    "Wyoming" => 56,
    "American Samoa" => 57,
    "Federated States of Micronesia" => 58,
    "Marshall Islands" => 59,
    "Northern Marina Islands" => 60,
    "Palau" => 61
  }

  def self.add_comment(name, email, address_line_1, zip, comment)
    # use geocoder to find the city and state based on address
    result = Geocoder.search("#{address_line_1} #{zip}").first

    agent = Mechanize.new
    # FCC dynamically changes the url to the express form, so you need to find the url on the listing and then click it first
    page = agent.get("http://apps.fcc.gov/ecfs/hotdocket/list")
    page2 = page.link_with(text: "14-28").click

    #find the first form and set the variables, then submit
    form = page2.forms[1]
    #form["procName"] = "14-28"
    form["applicant"] = name
    form["email"] = email
    form["address.line1"] = address_line_1
    form["address.line2"]
    form["address.city"] = result.city
    form["address.state.id"] = STATES[result.state]
    form["address.zip"] = zip
    form["address.plusFour"]
    form["briefComment"] = comment
    button = form.button_with(value: 'Continue')
    page = agent.submit(form, button)

    #click the confirmation link on the second page
    link = page.link_with(text: 'Confirm ').click
  end
end
