require "spec"
require "./utils"
require "../src/patches/**"
require "../src/caoutchouc/**"

# convenience aliases & methods
ESClient = Caoutchouc::Elasticsearch::Client

def client
  $client ||= ESClient.new
end
