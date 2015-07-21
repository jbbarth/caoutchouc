client = ESClient.new("http://localhost:9200")

describe Caoutchouc::Elasticsearch::Client do
  describe "#health" do
    it "returns raw health" do
      health = client.health
      health.should be_a(Caoutchouc::Elasticsearch::Health)
      health.status.should eq("green")
      health.cluster_name.should eq("elasticsearch")
    end
  end

  describe "#pretty_health" do
    it "returns a pretty version of health" do
      pretty = client.pretty_health
      pretty.should be_a(String)
      # indentation
      pretty.should contain("{\n  \"cluster_name\"")
      # colorized health
      pretty.should contain("\"\e[32mgreen\e[0m\"")
    end
  end
end
