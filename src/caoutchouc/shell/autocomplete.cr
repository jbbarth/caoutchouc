module Caoutchouc
  module Shell
    class Autocomplete
      getter :text, :start, :finish, :buffer

      def self.initialize_autocomplete!
        Readline.autocomplete do |text, start, finish|
          new(text, start: start, finish: finish).complete
        end
      end

      def initialize(@text, @start = 0, @finish = 0, @buffer = nil)
        @buffer ||= Readline.line_buffer
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

      private def beginning_of_line?
        start == 0
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
