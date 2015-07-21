describe Caoutchouc::Elasticsearch::Info do
  describe ".from_json" do
    it "parses json correctly" do
      response = <<-EOF
        {
          "status" : 200,
          "name" : "Hanna Levy",
          "cluster_name" : "elasticsearch",
          "version" : {
            "number" : "1.7.0",
            "build_hash" : "929b9739cae115e73c346cb5f9a6f24ba735a743",
            "build_timestamp" : "2015-07-16T14:31:07Z",
            "build_snapshot" : false,
            "lucene_version" : "4.10.4"
          },
          "tagline" : "You Know, for Search"
        }
      EOF
      info = Caoutchouc::Elasticsearch::Info.from_json(response)
      info.status.should eq(200)
      info.name.should eq("Hanna Levy")
    end
  end
end
