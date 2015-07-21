module Caoutchouc
  class Status < Command
    def name
      "status"
    end

    def short_doc
      "GET /_cluster/health : displays cluster health"
    end

    def run
      puts! client.health.pretty_to_json
    end
  end

  Command.register(Status.new)
end
