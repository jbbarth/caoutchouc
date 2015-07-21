require "readline"
require "./shell/*"

module Caoutchouc
  module Shell
    include Utils
    include Autocomplete

    def main_loop
      initialize_autocomplete!
      puts! welcome_message
      loop do
        input = Readline.readline(prompt)

        # Ctrl-D
        if input.nil?
          erase_current_line
          puts! "#{prompt}exit"
          exit
        end
        # let the compiler know we're sure we have a string now,
        # so it doesn't break on next lines (input.split <<)
        input = input as String

        next if input == ""

        command = input.split.first
        case command
        when "help"
          puts! "info     -- GET / : displays basic cluster informations"
          puts! "status   -- GET /_cluster/health : displays cluster health"
        when "info"
          puts! @client.info.to_pretty_json
        when "status"
          puts! @client.health.pretty_to_json
        else
          puts! "Unrecognized command: #{command}"
        end
      end
    end

    def welcome_message
      msg = [] of String
      msg << ""
      msg << "Welcome to Caoutchouc v#{Caoutchouc::VERSION}"
      msg << ""
      msg << "Watching cluster at: #{client.location.colorize(:cyan)}"
      msg << ""
      msg << "Current state is:"
      msg << ""
      msg << client.health.pretty_to_json.gsub(/(^|\n)/) { |s, m| "#{m[1]}    " }
      msg << ""
      msg << ""
      msg.join("\n")
    end
  end
end
