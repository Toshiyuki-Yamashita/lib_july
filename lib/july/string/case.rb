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
          def initialize(bloc)
            super(nil)
            @evalue = bloc
          end

          def when(*pattern, &)
            pattern.lazy.map(&@evalue).compact.first&.then do |m|
              __setobj__(yield m)
              instance_exec do
                def when(*_args, &) = self
                def else(&) = self
              end
            end
            self
          end

          def else(&)
            __setobj__(yield)
            self
          end
        end
      end
      refine ::String do
        # case matching method
        def case(&bloc)
          if block_given?
            Impl::CaseStubs.new(bloc.curry[self])
          else
            self.case { |str, arg| arg.match(str) }
          end
        end
      end
    end
  end
end
