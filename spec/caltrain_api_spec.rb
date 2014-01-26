require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CaltrainApi", :vcr => true do
  subject(:caltrain) { CaltrainApi::Client.new }
  describe "#routes" do
    it "returns the current list of routes" do
      routes = caltrain.routes

      expect(routes).to eq [
        {:code=>"NB", :name=>"NORTHBOUND TO SAN FRANCISCO", :route_code=>"BABY BULLET", :route_name=>"BABY BULLET"},
        {:code=>"SB1", :name=>"SOUTHBOUND TO SAN JOSE DIRIDON", :route_code=>"BABY BULLET", :route_name=>"BABY BULLET"},
        {:code=>"SB2", :name=>"SOUTHBOUND TO TAMIEN", :route_code=>"BABY BULLET", :route_name=>"BABY BULLET"},
        {:code=>"NB", :name=>"NORTHBOUND TO SAN FRANCISCO", :route_code=>"LIMITED", :route_name=>"LIMITED"},
        {:code=>"SB3", :name=>"SOUTHBOUND TO GILROY", :route_code=>"LIMITED", :route_name=>"LIMITED"},
        {:code=>"SB1", :name=>"SOUTHBOUND TO SAN JOSE DIRIDON", :route_code=>"LIMITED", :route_name=>"LIMITED"},
        {:code=>"SB2", :name=>"SOUTHBOUND TO TAMIEN", :route_code=>"LIMITED", :route_name=>"LIMITED"},
        {:code=>"NB", :name=>"NORTHBOUND TO SAN FRANCISCO", :route_code=>"LOCAL", :route_name=>"LOCAL"},
        {:code=>"SB3", :name=>"SOUTHBOUND TO GILROY", :route_code=>"LOCAL", :route_name=>"LOCAL"},
        {:code=>"SB1", :name=>"SOUTHBOUND TO SAN JOSE DIRIDON", :route_code=>"LOCAL", :route_name=>"LOCAL"},
        {:code=>"SB2", :name=>"SOUTHBOUND TO TAMIEN", :route_code=>"LOCAL", :route_name=>"LOCAL"}
      ]
    end
  end

  describe "#departures_for_stop" do
    it "returns the upcoming departures as a list of hashes" do
      departures = caltrain.departures_for_stop("Mountain View Caltrain Station")
      expect(departures).to eq [
        {:time_to_departure=>"35", :route_direction_code=>"SB1", :route_code=>"LOCAL"},
        {:time_to_departure=>"25", :route_direction_code=>"NB", :route_code=>"LOCAL"},
        {:time_to_departure=>"85", :route_direction_code=>"NB", :route_code=>"LOCAL"}
      ]
    end
  end

  describe "#all_stops" do
    it "returns all the stops as a list of strings" do
      all_stops = caltrain.all_stops
      expect(all_stops).to eq [
        "San Francisco Caltrain Station",
        "22nd Street Caltrain Station",
        "Bayshore Caltrain Station",
        "So San Francisco Caltrain Station",
        "San Bruno Caltrain Station",
        "Millbrae Caltrain Station",
        "Burlingame Caltrain Station",
        "San Mateo Caltrain Station",
        "Hayward Park Caltrain Station",
        "Hillsdale Caltrain Station",
        "Belmont Caltrain Station",
        "San Carlos Caltrain Station",
        "Redwood City Caltrain Station",
        "Menlo Park Caltrain Station",
        "Palo Alto Caltrain Station",
        "California Ave Caltrain Station",
        "San Antonio Caltrain Station",
        "Mountain View Caltrain Station",
        "Sunnyvale Caltrain Station",
        "Lawrence Caltrain Station",
        "Santa Clara Caltrain Station",
        "College Park Caltrain Station",
        "San Jose Diridon Caltrain Station",
        "Tamien Caltrain Station",
        "Capitol Caltrain Station",
        "Blossom Hill Caltrain Station",
        "Morgan Hill Caltrain Station",
        "San Martin Caltrain Station",
        "Gilroy Caltrain Station"
      ]
    end
  end
end
