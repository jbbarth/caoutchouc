module Caoutchouc
  module Elasticsearch
    class Settings
      def self.from_json(str : String) : Settings
        new(JSON.parse(str) as Hash)
      end

      def initialize(@json : Hash)
      end

      def persistent
        @json["persistent"]
      end

      def transient
        @json["transient"]
      end

      def to_pretty_json
        @json.to_pretty_json
      end
    end
  end
end
