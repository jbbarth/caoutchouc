module Caoutchouc
  class Settings < Command
    def name
      "settings"
    end

    def short_doc
      "GET|POST /_cluster/settings : set or get cluster settings"
    end

    def run
      puts! client.settings.flat_pretty_json
    end
  end

  Command.register(Settings.new)
end
