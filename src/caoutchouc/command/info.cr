module Caoutchouc
  class Info < Command
    def name
      "info"
    end

    def short_doc
      "GET / : displays basic cluster informations"
    end

    def run
      puts! client.info.to_pretty_json
    end
  end

  Command.register(Info.new)
end
