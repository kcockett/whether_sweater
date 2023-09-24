require "rails_helper"

RSpec.describe "Roadtrip API" do
  describe "POST /api/v0/road_trip" do

    describe "Happy path:  A properly formatted request returns a json response including:" do

      it "a data attribute, under which all other attributes are present"

      it "id, always set to null"

      it "type, always set to “roadtrip”"

      it "attributes, an object containing road trip information"

      it "start_city, string, such as “Cincinatti, OH”"

      it "end_city, string, such as “Chicaco, IL”"

      it "travel_time, string, something user-friendly like “2 hours, 13 minutes” or “2h13m” or “02:13:00”. Set this string to “impossible route” if there is no route between your cities"

      it "weather_at_eta, conditions at end_city when you arrive, object containing:"

      it "datetime, date and time for the reported weather at the destination at the approximate hour of arrival"

      it "temperature, numeric value in Fahrenheit"

      it "condition, the text description for the weather condition at that hour.  note: this object will be blank if the travel time is impossible"
    end
  end
end