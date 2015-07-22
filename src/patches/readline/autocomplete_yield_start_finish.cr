require "readline"

module Readline
  # ADD
  alias CompletionProcWithStartFinish = String, Int32, Int32 -> Array(String)?
  # /ADD

  # CHANGE
  # old: def autocomplete(&@@completion_proc : CompletionProc)
  #      end
  def autocomplete(&@@completion_proc_with_start_finish : CompletionProcWithStartFinish)
  end
  # END OF CHANGE

  LibReadline.rl_attempted_completion_function = ->(text_ptr, start, finish) {
    # CHANGE
    #old: completion_proc = @@completion_proc
    completion_proc = @@completion_proc_with_start_finish
    # END OF CHANGE
    return Pointer(UInt8*).null unless completion_proc

    text = String.new(text_ptr)
    # CHANGE
    #old: matches = completion_proc.call(text)
    matches = completion_proc.call(text, start, finish)
    # END OF CHANGE

    return Pointer(UInt8*).null unless matches
    return Pointer(UInt8*).null if matches.empty?

    result = LibC.malloc(sizeof(UInt8*).to_u32 * (matches.length + 1)) as UInt8**
    matches.each_with_index do |match, i|
      match_ptr = LibC.malloc(match.bytesize.to_u32 + 1) as UInt8*
      match_ptr.copy_from(match.to_unsafe, match.bytesize)
      match_ptr[match.bytesize] = 0_u8
      result[i] = match_ptr
    end
    result[matches.length] = Pointer(UInt8).null
    result
  }
end
