# frozen_string_literal: true

# utility library for ruby
module July
  autoload :VERSION, "july/version"
  autoload :Error, "july/common/exception"
  autoload :UnexpectedMethodCall, "july/common/exception"
  module String
    autoload :Case, "july/string/case"
  end
end
