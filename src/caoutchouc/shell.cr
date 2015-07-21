require "./shell/*"

module Caoutchouc
  module Shell
    include Utils

    def welcome_message
      msg = [] of String
      msg << ""
      msg << "Welcome to Caoutchouc v#{Caoutchouc::VERSION}"
      msg << ""
      msg << "Watching cluster at: #{client.location.colorize(:cyan)}"
      msg << ""
      msg << "Current state is:"
      msg << ""
      msg << client.pretty_health.gsub(/(^|\n)/) { |s, m| "#{m[1]}    " }
      msg << ""
      msg << ""
      msg.join("\n")
    end
  end
end
