require 'rubygems'
require 'mechanize'
require 'open-uri'

module Post
  module Fcc
    def self.add_comment(name, email, address_line_1, city, state, zip, comment)
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
      form["address.city"] = city
      form["address.state.id"] = state
      form["address.zip"] = zip
      form["address.plusFour"]
      form["briefComment"] = comment
      button = form.button_with(value: 'Continue')
      page = agent.submit(form, button)

      #click the confirmation link on the second page
      link = page.link_with(text: 'Confirm ').click
    end
  end
end
