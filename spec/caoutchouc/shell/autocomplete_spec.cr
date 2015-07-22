AC = Caoutchouc::Shell::Autocomplete

describe Caoutchouc::Shell::Autocomplete do
  describe "#complete" do
    context "for command" do
      it "returns only one command if exact match" do
        AC.new("help", buffer: "help").complete.should eq(["help "])
      end

      it "returns given text AND candidates when no exact match but many possibilities" do
        possibilities = AC.new("", "").complete
        possibilities[0].should eq("")
        possibilities.should contain("help ")
      end

      it "returns nothing if unknown command" do
        AC.new("does-not-exist", "does-not-exist").complete.should eq([] of String)
      end
    end

    context "for arguments" do
      it "returns nothing (for now) if command is already set" do
        AC.new("", "help").complete.should eq([] of String)
        AC.new("foo", "help foo").complete.should eq([] of String)
        AC.new("foo", "unknown-command foo").complete.should eq([] of String)
      end
    end
  end
end
