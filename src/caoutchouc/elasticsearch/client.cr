require "colorize"
require "json"
require "http/client"

module Caoutchouc
  module Elasticsearch
    class Client
      getter :location, :secondary_locations

      def initialize(addresses : String | Array(String))
        addresses = [addresses] if addresses.is_a?(String)

        @location = addresses.shift
        @secondary_locations = addresses
      end

      def health
        #TODO: catch the case where we cannot connect
        result = HTTP::Client.get("#{location}/_cluster/health")
        if result.status_code == 200
          Health.from_json(result.body)
        else
          error("Failed to retrieve status")
        end
      end

      def pretty_health
        health.colorized_to_json
      end

      private def client
        @client ||= HTTP::Client.new(location)
      end
    end
  end
end
