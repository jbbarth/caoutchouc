module Caoutchouc
  module Shell
    class Autocomplete
      getter :text, :buffer

      def self.initialize_autocomplete!
        Readline.autocomplete do |text|
          new(text).complete
        end
      end

      def initialize(@text, @buffer = Readline.line_buffer)
      end

      def complete : Array(String)
        if beginning_of_line?
          complete_for_command
        else
          complete_for_arguments(find_command)
        end
      end

      private def complete_for_command : Array(String)
        result = [] of String
        Command.all.each do |cmd|
          if cmd.name.starts_with?(text)
            result << "#{cmd.name} "
          end
        end
        if result.count > 1
          result.insert(0, text)
        end
        return result
      end

      private def complete_for_arguments(command) : Array(String)
        return [] of String
      end

      # This is not perfect but for now, crystal autocomplete binding does not
      # yield "start" and "finish" positions, so we have to guess what to do
      # depending on yielded text and line buffer
      # TODO: explain that upstream and make a PR
      private def beginning_of_line?
        text == buffer
      end

      private def find_command : Command|Nil
        if text == ""
          nil
        else
          command_name = text.split.first
          Command.find(command_name)
        end
      end
    end
  end
end
