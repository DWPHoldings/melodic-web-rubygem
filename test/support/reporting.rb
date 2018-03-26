module Kernel
  def silence_stdout_if(cond, &block)
    silence_stream_if(cond, STDOUT, &block)
  end

  def silence_stderr_if(cond, &block)
    silence_stream_if(cond, STDERR, &block)
  end

  def silence_stream_if(cond, stream, &block)
    if cond
      silence_stream(stream, &block)
    else
      yield
    end
  end

  if !method_defined?(:silence_stream)
    def silence_stream(stream)
      old_stream = stream.dup
      stream.reopen(File::NULL)
      stream.sync = true
      yield
    ensure
      stream.reopen(old_stream)
      old_stream.close
    end
  end
end
