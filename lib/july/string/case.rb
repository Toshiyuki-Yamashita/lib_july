# frozen_string_literal: true

require "delegate"

module July
  module String
    # refinement module for case matching
    module Case
      # implementation classes
      module Impl
        # case implementation
        class CaseStubs < SimpleDelegator
          def initialize(str, bloc)
            super(nil)
            @input = [str, bloc.curry[str]]
          end

          def when(*pattern, &)
            _, bloc = @input
            pattern.lazy.map(&bloc).compact.first&.then do |m|
              __setobj__(yield(*m))
              instance_exec do
                def when(*_args, &) = self
                def else(&) = self
              end
            end
            self
          end

          def else(&)
            str, = @input
            __setobj__(yield str)
            self
          end
        end
      end
      refine ::String do
        # case matching method
        def case(&bloc)
          if block_given?
            Impl::CaseStubs.new(self, bloc)
          else
            self.case { |str, arg| arg.match(str)&.then { |m| [str, m] } }
          end
        end
      end
    end
  end
end
