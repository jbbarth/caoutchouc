require "readline"

lib LibReadline
  fun rl_replace_line(...)
  fun rl_redisplay
end

module Readline
  def replace_line(str)
    LibReadline.rl_replace_line(str, 0)
  end

  def redisplay
    LibReadline.rl_redisplay
  end
end
