describe Caoutchouc::Elasticsearch::Settings do
  describe ".from_json" do
    it "parses json correctly" do
      response = <<-EOF
        {
          "persistent" : {
            "cluster" : {
              "routing" : {
                "allocation" : {
                  "balance" : {
                    "primary" : "0.5"
                  }
                }
              }
            }
          },
          "transient" : {
            "indices" : {
              "store" : {
                "throttle" : {
                  "max_bytes_per_sec" : "4mb"
                }
              },
              "recovery" : {
                "concurrent_streams" : "12",
                "max_bytes_per_sec" : "1mb"
              }
            },
            "cluster" : {
              "routing" : {
                "allocation" : {
                  "enable" : "all",
                  "cluster_concurrent_rebalance" : "12",
                  "exclude" : {
                    "_host" : "foo.example.net",
                    "_ip" : "10.63.183.11"
                  },
                  "node_concurrent_recoveries" : "2"
                }
              }
            }
          }
        }
      EOF
      res = Caoutchouc::Elasticsearch::Settings.from_json(response)
      res.transient.should_not be_nil
    end
  end

  describe "#flatten" do
    it "flattens simple keys" do
      res = Caoutchouc::Elasticsearch::Settings.flatten(
        { "one" => { "two" => { "three" => "yay" } } }
      )
      res.to_json.should eq(%({"one.two.three":"yay"}))
    end
  end

  describe "#flat" do
    it "preserves transient/persistent top-level keys" do
      res = Caoutchouc::Elasticsearch::Settings.from_json(%(
        {
          "persistent": { "one": { "two": { "three": "yay" } } },
          "transient": { "four": { "five": "foo" } }
        }
      ))
      res.flat.to_json.should eq(
        %({"persistent":{"one.two.three":"yay"},"transient":{"four.five":"foo"}})
      )
    end
  end
end
