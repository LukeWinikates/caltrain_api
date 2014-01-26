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
end
