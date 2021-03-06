module EitherMatchers

  def be_defined
    BeDefined.new
  end

  class BeDefined
    def matches?(either)
      @either = either
      either.defined?
    end

    def failure_message_for_should
      "expected Either.success, got #{@either.inspect}"
    end

    def failure_message_for_should_not
      "expected Either.failure, got #{@either.inspect}"
    end

    def description
      "be defined"
    end
  end

end
