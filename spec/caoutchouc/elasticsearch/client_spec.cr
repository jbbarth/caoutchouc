describe Caoutchouc::Elasticsearch::Client do
  describe "#initialize" do
    it "defaults to localhost:9200" do
      with_env "CAOUTCHOUC_ES_LOCATION", nil do
        client = ESClient.new()
        client.location.should eq("http://localhost:9200")
      end
    end

    it "defaults to CAOUTCHOUC_ES_LOCATION if present" do
      with_env "CAOUTCHOUC_ES_LOCATION", "foo" do
        client = ESClient.new()
        client.location.should eq("foo")
      end
    end

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
