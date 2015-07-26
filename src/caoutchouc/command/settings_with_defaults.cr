module Caoutchouc
  class SettingsWithDefaults < Command
    def name
      "settings_with_defaults"
    end

    def short_doc
      "GET /_cluster/settings + include default values for some important settings"
    end

    def run
      settings = client.settings
      settings.with_defaults = true
      puts! settings.flat_pretty_json
    end
  end

  Command.register(SettingsWithDefaults.new)
end
