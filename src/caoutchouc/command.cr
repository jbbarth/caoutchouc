require "./shell"

module Caoutchouc
  class Command
    include Caoutchouc::Shell::Utils

    @@all = [] of Command

    def self.all
      @@all
    end

    def self.register(cls)
      @@all << cls
    end

    def self.find(name) : Command|Nil
      @@all.each do |cmd|
        return cmd if cmd.name == name
      end
      return nil
    end

    def client
      Elasticsearch.client
    end

    # helps the compiler
    def name; "<none>"; end
    def short_doc; "<none>"; end
    def run; nil; end
  end
end
