require 'rest_client'
require 'nokogiri'
require 'nori'

module CaltrainApi
  class Client
    def routes
      RestClient.get("services.my511.org/Transit2.0/GetRoutesForAgency.aspx", :params => {:token => auth_token, :agencyName => "Caltrain"}) do |response, request|
        hash = Nori.new.parse(response)
        route_lists = hash["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]
        route_lists.map do |route|
          route["RouteDirectionList"]["RouteDirection"].map do |route_direction|
            {
              :code => route_direction["@Code"],
              :name => route_direction["@Name"],
              :route_code => route["@Code"],
              :route_name => route["@Name"]
            }
          end
        end.flatten
      end
    end


    def departures_for_stop(stop)
      params = {
        :token => auth_token,
        :agencyName => "Caltrain",
        :stopName => stop
      }
      RestClient.get("services.my511.org/Transit2.0/GetNextDeparturesByStopName.aspx", :params => params) do |response, request|
        noko = Nokogiri::XML.parse response
        noko.css('DepartureTime').map do |departure_time|
          {
            :time_to_departure => departure_time.text,
            :route_direction_code => departure_time.ancestors('RouteDirection')[0].attribute('Code').value,
            :route_code => departure_time.ancestors('Route')[0].attribute('Code').value
          }
        end
      end
    end

    def all_stops
      params = {
        :token => auth_token,
        :routeIdf => all_idfs.join("|")
      }
      RestClient.get("services.my511.org/Transit2.0/GetStopsForRoutes.aspx", :params => params) do |response, request|
        noko = Nokogiri::XML.parse response
        noko.css('Stop').map do |stop|
          stop.attribute('name').value
        end.uniq
      end
    end

    def auth_token
      self.class.configuration[:auth_token]
    end

    def self.configure
      yield configuration
    end

    def self.configuration
      @@configuration ||= {}
    end

    private

    def all_idfs
      ["LOCAL", "LIMITED"].map do |route|
        ["NB", "SB1", "SB2", "SB3"].map do |route_direction|
          "Caltrain~#{route}~#{route_direction}"
        end
      end +
      ["NB", "SB1", "SB2"].map do |route_direction|
        "Caltrain~BABY BULLET~#{route_direction}"
      end
    end
  end
end
