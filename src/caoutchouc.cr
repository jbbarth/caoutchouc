require "./patches/**"
require "./caoutchouc/**"

module Caoutchouc
  class CLI
    include Shell

    def initialize(args)
      debug "Observing cluster at: #{args.inspect}"
      puts STDIN.tty?
      if args.size == 0
        location = "http://localhost:9200"
      else
        location = args.first
      end
      Caoutchouc::Elasticsearch.set_location(location)
      main_loop()
    end
  end
end

Caoutchouc::CLI.new(ARGV)
