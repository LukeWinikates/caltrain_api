require 'rest_client'
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

    def auth_token
      self.class.configuration[:auth_token]
    end

    def self.configure
      yield configuration
    end

    def self.configuration
      @@configuration ||= {}
    end
  end
end
