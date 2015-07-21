describe Caoutchouc::Elasticsearch::Version do
  describe ".from_json" do
    it "parses json correctly" do
      response = <<-EOF
        {
          "number" : "1.7.0",
          "build_hash" : "929b9739cae115e73c346cb5f9a6f24ba735a743",
          "build_timestamp" : "2015-07-16T14:31:07Z",
          "build_snapshot" : false,
          "lucene_version" : "4.10.4"
        }
      EOF
      version = Caoutchouc::Elasticsearch::Version.from_json(response)
      version.lucene_version.should eq("4.10.4")
      version.build_snapshot.should eq(false)
    end
  end
end
