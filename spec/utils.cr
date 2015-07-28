# Overrides an environment variable for the duration of the block
# and restores previous value afterwards
#
# Usage:
#
#   with_env "KEY", "value" { ... }
#
def with_env(key, value : Nil|String, &block)
  old_value = ENV.has_key?(key) ? ENV[key] : nil
  begin
    if value
      ENV[key] = value as String
    else
      ENV.delete(key)
    end
    yield
  ensure
    if old_value
      ENV[key] = old_value
    else
      ENV.delete(key)
    end
  end
end
