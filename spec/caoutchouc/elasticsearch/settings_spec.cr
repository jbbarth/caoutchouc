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

  describe "#flat" do
    it "flattens simple keys" do
      res = Caoutchouc::Elasticsearch::Settings.from_json(%({
        "one": {
          "two": {
            "three": "yay"
          }
        }
      }))
      res.flat.to_json.should eq(%({"one.two.three":"yay"}))
    end
  end
end
