require "./*"

module Caoutchouc
  class Help < Command
    def name
      "help"
    end

    def short_doc
      "displays help about other commands"
    end

    def run
      Command.all.sort_by(&.name).each do |cmd|
        puts! " #{cmd.name.ljust(12)}  -- #{cmd.short_doc}"
      end
    end
  end

  Command.register(Help.new)
end
