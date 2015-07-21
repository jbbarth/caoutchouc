require "json"

module Caoutchouc
  module Elasticsearch
    class Health
      json_mapping({
        cluster_name: {type: String},
        status: {type: String},
        timed_out: {type: Bool},
        number_of_nodes: {type: Int32},
        number_of_data_nodes: {type: Int32},
        active_primary_shards: {type: Int32},
        active_shards: {type: Int32},
        relocating_shards: {type: Int32},
        initializing_shards: {type: Int32},
        unassigned_shards: {type: Int32},
      })

      def colorized_to_json
        result = to_pretty_json
        if status == "green"
          color = :green
        elsif status == "yellow"
          color = :yellow
        else
          color = :red
        end
        colored = %("status": "#{status.colorize(color)}",)
        result.gsub /"status":.*/, colored
      end
    end
  end
end
