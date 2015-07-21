# This file groups utility methods we could use everywhere

require "colorize"

def debug(msg)
  if ENV.has_key?("DEBUG")
    puts "DEBUG: #{msg}"
  end
end

def error(msg)
  puts msg.colorize(:red)
  exit 1
end
