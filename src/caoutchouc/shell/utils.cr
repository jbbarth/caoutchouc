module Caoutchouc
  module Shell
    module Utils
      def puts!(msg = "" : T)
        puts msg
        STDOUT.flush
      end

      def prompt
        "> "
      end

      def erase_current_line
        print! "\e[2K\r"
      end

      def erase_screen
        print! "\e[2J\r"
      end

      def erase_previous_line
        print! "\e[1A\r\e[K\r"
      end
    end
  end
end
