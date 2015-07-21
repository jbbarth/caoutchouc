describe Caoutchouc::Elasticsearch::Health do
  describe ".from_json" do
    it "parses json correctly" do
      response = <<-EOF
        {
          "cluster_name": "elasticsearch",
          "status": "green",
          "timed_out": false,
          "number_of_nodes": 4,
          "number_of_data_nodes": 2,
          "active_primary_shards": 384,
          "active_shards": 768,
          "relocating_shards": 0,
          "initializing_shards": 0,
          "unassigned_shards": 0
        }
      EOF
      res = Caoutchouc::Elasticsearch::Health.from_json(response)
      res.status.should eq("green")
      res.active_shards.should eq(768)
    end
  end
end
