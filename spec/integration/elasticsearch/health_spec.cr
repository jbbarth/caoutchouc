describe Caoutchouc::Elasticsearch::Health do
  describe "#pretty_to_json" do
    it "returns a pretty version of health" do
      pretty = client.health.pretty_to_json
      pretty.should be_a(String)
      # indentation
      pretty.should contain("{\n  \"cluster_name\"")
      # colorized health
      pretty.should contain("\"\e[32mgreen\e[0m\"")
    end
  end
end
