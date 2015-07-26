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

      # TODO: move it elsewhere?
      def flatten(json_tree, prefix = nil)
        res = {} of String => JSON::Type

        json_tree.each do |key, value|
          new_key = prefix ? "#{prefix}.#{key}" : key
          if value.is_a?(Hash)
            res.merge!(flatten(value, new_key))
          else
            res[new_key] = value
          end
        end

        res
      end

      def flat
        flatten(@json)
      end
    end
  end
end
