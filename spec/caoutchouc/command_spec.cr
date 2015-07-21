describe Caoutchouc::Command do
  describe "#all" do
    it "returns a list of commands" do
      cmds = Caoutchouc::Command.all
      cmds.first.should be_a(Caoutchouc::Command)
    end
  end

  describe "#find" do
    it "finds a command by its name" do
      cmd = Caoutchouc::Command.find("help")
      cmd.should be_a(Caoutchouc::Command)
      cmd = cmd as Caoutchouc::Command # help the compiler
      cmd.name.should eq("help")
    end

    it "returns nil if no command matches" do
      cmd = Caoutchouc::Command.find("does-not-exist")
      cmd.should be_nil
    end
  end
end
