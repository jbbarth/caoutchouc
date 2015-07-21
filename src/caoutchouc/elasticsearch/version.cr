module Caoutchouc
  module Elasticsearch
    class Version
      json_mapping({
        number: {type: String},
        build_hash: {type: String},
        #TODO: switch to Time type
        #ex: {type: Time, converter: TimeFormat.new("%a %b %d %T +0000 %Y")}
        build_timestamp: {type: String},
        build_snapshot: {type: Bool},
        lucene_version: {type: String},
      })
    end
  end
end
