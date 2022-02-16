# frozen_string_literal: true

require "delegate"

# refinement module for case matching
module Case
  # implementation classes
  module Impl
    # case implementation
    class CaseStubs < SimpleDelegator
      def initialize(str)
        super
        __setobj__(nil)
        @input = str
      end

      def when(*pattern, &)
        pattern.lazy.map { |pat| pat.match(@input) }.compact.first&.then do |m|
          __setobj__(yield @input, m)
          %i[when else].each do |name|
            instance_eval "def #{name}(*arg, &) = self", __FILE__, __LINE__
          end
        end
        self
      end

      def else(&)
        __setobj__(yield @input)
        self
      end
    end
  end
  refine String do
    # case matching method
    def case
      Impl::CaseStubs.new(self)
    end
  end
end
