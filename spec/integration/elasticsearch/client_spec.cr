describe Caoutchouc::Elasticsearch::Client do
  describe "#health" do
    it "returns raw health" do
      health = client.health
      health.should be_a(Caoutchouc::Elasticsearch::Health)
      health.status.should eq("green")
      health.cluster_name.should eq("elasticsearch")
    end
  end
end
