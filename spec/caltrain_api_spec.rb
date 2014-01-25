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
end
