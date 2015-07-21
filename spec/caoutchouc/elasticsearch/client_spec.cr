describe Caoutchouc::Elasticsearch::Client do
  describe "#initialize" do
    it "accepts a single string" do
      client = ESClient.new("foo")
      client.location.should eq("foo")
      client.secondary_locations.should eq([] of String)
    end

    it "accepts multiple addreses" do
      client = ESClient.new(["foo", "bar"])
      client.location.should eq("foo")
      client.secondary_locations.should eq(["bar"])
    end
  end
end
