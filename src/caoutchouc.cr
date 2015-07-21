require "./caoutchouc/**"

module Caoutchouc
  class CLI
    include Shell

    getter :client

    def initialize(args)
      debug "Observing cluster at: #{args.inspect}"
      if args.size == 0
        STDERR.puts "Usage: #{PROGRAM_NAME} <address>"
        #TODO: remove this line when https://github.com/manastech/crystal/pull/975 is released
        STDERR.flush
        exit 1
      end
      @client = Elasticsearch::Client.new(args)
      main_loop()
    end

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
        puts! "You typed #{input}"
      end
    end

  end
end

Caoutchouc::CLI.new(ARGV)
