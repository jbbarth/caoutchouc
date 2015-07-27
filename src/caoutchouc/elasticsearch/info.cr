require "json"

module Caoutchouc
  module Elasticsearch
    class Info
      json_mapping({
        status: {type: Int64},
        name: {type: String},
        cluster_name: {type: String, nilable: true},
        version: {type: Caoutchouc::Elasticsearch::Version},
        tagline: {type: String},
      })
    end
  end
end
