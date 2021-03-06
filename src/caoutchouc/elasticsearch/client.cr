require "colorize"
require "json"
require "http/client"

module Caoutchouc
  module Elasticsearch
    @@location = nil

    def self.set_location(@@location)
    end

    def self.client
      @@client ||= Elasticsearch::Client.new(@@location)
    end

    class Client

      getter :location

      def initialize()
        if ENV.has_key?("CAOUTCHOUC_ES_LOCATION")
          @location = ENV["CAOUTCHOUC_ES_LOCATION"]
        else
          @location = "http://localhost:9200"
        end
      end

      def initialize(nil)
        initialize
      end

      def initialize(@location : String)
      end

      def health : Health
        #TODO: catch the case where we cannot connect
        result = get("/_cluster/health")
        if result.status_code == 200
          Health.from_json(result.body)
        else
          error("Failed to retrieve status")
        end
      end

      def info : Info
        #TODO: catch the case where we cannot connect
        result = get("/")
        if result.status_code == 200
          Info.from_json(result.body)
        else
          error("Failed to retrieve info")
        end
      end

      def cluster_state : ClusterState
        #TODO: catch the case where we cannot connect
        result = get("/_cluster/state")
        if result.status_code == 200
          ClusterState.from_json(result.body)
        else
          error("Failed to retrieve cluster state")
        end
      end

      def nodes : Hash(String, ClusterStateNode)
        cluster_state.nodes
      end

      def settings : Settings
        #TODO: catch the case where we cannot connect
        result = get("/_cluster/settings")
        if result.status_code == 200
          Settings.from_json(result.body)
        else
          error("Failed to retrieve cluster settings")
        end
      end

      private def get(endpoint)
        HTTP::Client.get("#{location}#{endpoint}")
      end
    end
  end
end
