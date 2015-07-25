describe Caoutchouc::Elasticsearch::ClusterState do
  describe ".from_json" do
    it "parses json correctly" do
      response = File.read("spec/data/api_responses/cluster_state.json")
      res = Caoutchouc::Elasticsearch::ClusterState.from_json(response)
      res.cluster_name.should eq("elasticsearch")
      res.version.should eq(5)
      res.metadata.indices.keys.should contain("foo")
    end
  end
end
