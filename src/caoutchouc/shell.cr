require "./shell/*"

module Caoutchouc
  module Shell
    include Utils

    def main_loop
      puts! welcome_message
      loop do
        prompt
        begin
          input = read_line
        rescue IO::EOFError #Ctrl+D
          puts! "exit"
          exit
        end
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
