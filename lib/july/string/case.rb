# frozen_string_literal: true

require "delegate"

module July
  module String
    # refinement module for case matching
    module Case
      # implementation classes
      module Impl
        # case implementation
        class CaseStubs
          def initialize(bloc)
            @evalue = bloc
            @ret = nil
          end

          def when(*pattern, &)
            pattern.lazy.map(&@evalue).compact.first&.then do |m|
              @ret = yield m
              instance_exec do
                def when(*_args, &) = self
                def else(&) = self
              end
            end
            self
          end

          def else(&)
            @ret = yield
            self
          end

          def end() = @ret
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
