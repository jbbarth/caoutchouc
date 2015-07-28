require "readline"
require "signal"
require "./shell/*"

module Caoutchouc
  module Shell
    include Utils

    def main_loop
      if interactive?
        main_loop_interactive
      else
        main_loop_from_stdin
      end
    end

    def main_loop_interactive
      Autocomplete.initialize_autocomplete!
      initialize_traps!
      puts! welcome_message

      loop do
        input = Readline.readline(prompt)

        # Ctrl-D
        if input.nil?
          ctrl_d_handler
          exit
        end

        # let the compiler know we're sure we have a string now,
        # so it doesn't break on next lines (input.split <<)
        input = input as String

        # empty input
        next if input == ""

        # here we have a command to work on
        command_name = input.split.first
        if command = Command.find(command_name)
          command.run
        else
          puts! "Unrecognized command: #{command_name}"
        end
      end
    end

    def main_loop_from_stdin
      STDIN.read.lines.each do |line|
        input = line.chomp

        next if input == ""

        # here we have a command to work on
        command_name = input.split.first
        if command = Command.find(command_name)
          command.run
        else
          STDERR.puts "Unrecognized command: #{command_name}"
          STDERR.flush
        end
      end
    end

    def ctrl_d_handler
      erase_current_line
      puts! "#{prompt}exit"
    end

    def ctrl_c_handler
      print! "\n"
      Readline.replace_line("")
      Readline.redisplay
      print! prompt
    end

    def initialize_traps!
      Signal::INT.trap do
        ctrl_c_handler
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

    def client
      Elasticsearch.client
    end

    def interactive?
      STDIN.tty?
    end
  end
end
