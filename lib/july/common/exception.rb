# frozen_string_literal: true

module July
  # unspecified error
  class Error < StandardError; end
  # unexpected method call
  class UnexpectedMethodCall < StandardError; end
end
