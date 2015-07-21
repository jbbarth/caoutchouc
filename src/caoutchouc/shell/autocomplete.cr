module Caoutchouc
  module Shell
    module Autocomplete
      def initialize_autocomplete!
        Readline.autocomplete do |text|
          autocomplete(text)
        end
      end

      def autocomplete(text)
        [] of String
      end
    end
  end
end
