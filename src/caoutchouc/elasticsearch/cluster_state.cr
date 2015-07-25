module Caoutchouc
  module Elasticsearch
    class ClusterState
      json_mapping({
        cluster_name: {type: String},
        version: {type: Int32},
        master_node: {type: String},
        blocks: {type: JSON::Any},
        nodes: {type: Hash(String, ClusterStateNode)},
        metadata: {type: ClusterStateMetadata},
        routing_table: {type: JSON::Any}, # TODO
        routing_nodes: {type: JSON::Any}, # TODO
        allocations: {type: JSON::Any}, # TODO
      })
    end

    class ClusterStateNode
      json_mapping({
        name: {type: String},
        transport_address: {type: String},
        attributes: {type: JSON::Any}, # TODO
      })
    end

    class ClusterStateMetadata
      json_mapping({
        templates: {type: JSON::Any}, # TODO
        indices: {type: Hash(String, ClusterStateIndex)},
      })
    end

    class ClusterStateIndex
      json_mapping({
        state: {type: String},
        settings: {type: JSON::Any}, # TODO
        mapping: {type: JSON::Any, nilable: true, emit_null: false}, # TODO
        aliases: {type: JSON::Any}, # TODO
      })
    end
  end
end
