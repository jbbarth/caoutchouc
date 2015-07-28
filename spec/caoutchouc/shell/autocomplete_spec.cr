AC = Caoutchouc::Shell::Autocomplete

describe Caoutchouc::Shell::Autocomplete do
  describe "#complete" do
    context "for command" do
      it "returns only one command if exact match" do
        AC.new("help", buffer: "help").complete.should eq(["help"])
      end

      it "returns given text AND candidates when no exact match but many possibilities" do
        possibilities = AC.new("", buffer: "").complete
        possibilities[0].should eq("")
        possibilities.should contain("help")
      end

      it "returns nothing if unknown command" do
        AC.new("does-not-exist", buffer: "does-not-exist").complete.should eq([] of String)
      end

      it "completes the command up to where possible" do
        possibilities = AC.new("set", buffer: "set").complete
        possibilities[0].should eq("settings")
      end
    end

    context "for arguments" do
      it "returns nothing (for now) if command is already set" do
        AC.new("", buffer: "help", position: 4).complete.should eq([] of String)
        AC.new("foo", buffer: "help foo", position: 5).complete.should eq([] of String)
        AC.new("foo", buffer: "unknown-command foo", position: 16).complete.should eq([] of String)
      end
    end

    context "#common_denominator" do
      it "completes up to the smaller common denominator" do
        tests = [
          { text: "", candidates: ["foo", "bar"], result: "" },
          { text: "", candidates: ["foom", "foozr"], result: "foo" },
          { text: "f", candidates: ["foo", "fogz"], result: "fo" },
          { text: "foo", candidates: ["foo", "fooz"], result: "foo" },
        ]
        tests.each do |hsh|
          ac = AC.new(hsh[:text] as String, buffer: "")
          ac.common_denominator(hsh[:candidates] as Array(String)).should eq(hsh[:result])
        end
      end
    end
  end
end
