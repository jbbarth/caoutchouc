describe Caoutchouc::Elasticsearch::Client do
  describe "#health" do
    it "returns raw health" do
      health = client.health
      health.should be_a(Caoutchouc::Elasticsearch::Health)
      health.status.should eq("green")
      health.cluster_name.should eq("elasticsearch")
    end
  end

  describe "#cluster_state" do
    it "returns cluster state" do
      res = client.cluster_state
      res.should be_a(Caoutchouc::Elasticsearch::ClusterState)
      res.cluster_name.should eq("elasticsearch")
    end
  end

  describe "#nodes" do
    it "returns nodes from cluster state" do
      res = client.nodes
      res.length.should eq(1)
      res.first.should be_a({String, Caoutchouc::Elasticsearch::ClusterStateNode})
    end
  end
end
