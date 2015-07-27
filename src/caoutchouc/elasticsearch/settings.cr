module Caoutchouc
  module Elasticsearch
    class Settings
      # This lists default values for some of the settings documented at
      # https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-update-settings.html
      # For now we only take care of settings that have an effect even
      # when not set ; for instance we don't list some other settings
      # like cluster.routing.allocation.awareness.* ; that may change
      # in the future.
      DEFAULTS = {
        "cluster.routing.allocation.balance.shard"                      => "0.45f",
        "cluster.routing.allocation.balance.index"                      => "0.55f",
        "cluster.routing.allocation.balance.primary"                    => "0.00f",
        "cluster.routing.allocation.balance.threshold"                  => "1.0f",
        "cluster.routing.allocation.cluster_concurrent_rebalance"       => "2",
        "cluster.routing.allocation.enable"                             => "all",
        "cluster.routing.allocation.node_initial_primaries_recoveries"  => "4",
        "cluster.routing.allocation.node_concurrent_recoveries"         => "2",
        "discovery.zen.minimum_master_nodes"                            => nil,
        "discovery.zen.publish_timeout"                                 => "30s",
        #TODO: threadpool.*
        "indices.cache.filter.size"                                     => "10%",
        "indices.cache.filter.expire"                                   => nil,
        "indices.ttl.interval"                                          => "60s",
        "indices.recovery.concurrent_streams"                           => "3",
        "indices.recovery.concurrent_small_file_streams"                => "2",
        "indices.recovery.file_chunk_size"                              => "512kb",
        "indices.recovery.translog_ops"                                 => "1000",
        "indices.recovery.translog_size"                                => "512kb",
        "indices.recovery.compress"                                     => "true",
        "indices.recovery.max_bytes_per_sec"                            => "40mb",
        "indices.store.throttle.type"                                   => "merge",
        "indices.store.throttle.max_bytes_per_sec"                      => "20mb",
        "indices.breaker.fielddata.limit"                               => "unbounded",
        "indices.fielddata.cache.expire"                                => "-1",
      }

      def self.from_json(str : String) : Settings
        new(JSON.parse(str) as Hash)
      end

      getter :with_defaults

      def initialize(@json : Hash)
        @with_defaults = false
        @json_with_defaults = Hash(String, JSON::Type).new
        @json["persistent"] ||= Hash(String, JSON::Type).new
        @json["transient"] ||= Hash(String, JSON::Type).new
      end

      def with_defaults=(value : Bool)
        @with_defaults = value
      end

      def json
        if with_defaults
          return @json_with_defaults unless @json_with_defaults.empty?
          @json_with_defaults = @json.clone
          DEFAULTS.each do |setting, default_value|
            pers = self.class.flatten(@json["persistent"]) as Hash #help the compiler
            trans = self.class.flatten(@json["transient"]) as Hash #help the compiler
            if ! pers.has_key?(setting) && ! trans.has_key?(setting)
              new_pers = @json_with_defaults["persistent"] as Hash #help the compiler
              new_pers["(default)#{setting}"] = default_value
            end
          end
          @json_with_defaults
        else
          @json
        end
      end

      def persistent : Hash
        json["persistent"] as Hash
      end

      def transient : Hash
        json["transient"] as Hash
      end

      def to_pretty_json
        json.to_pretty_json
      end

      # TODO: move it elsewhere?
      def self.flatten(json_tree, prefix = nil)
        res = {} of String => JSON::Type

        json_tree = json_tree as Hash
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
        {
          "persistent" => self.class.flatten(persistent),
          "transient"  => self.class.flatten(transient),
        }
      end

      def flat_pretty_json
        flat.to_pretty_json.gsub(/"\(default\)(.+)": (.+)\n/) do |str, match|
          grey(%["#{match[1]}": #{match[2]}])+"\n"
        end
      end

      def grey(txt)
        Colorize::Object.new(txt).fore(:black).back(:dark_gray).to_s
      end
    end
  end
end
