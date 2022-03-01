# frozen_string_literal: true

require "delegate"

module July
  module String
    # refinement module for case matching
    module Case
      # implementation classes
      module Impl
        # case implementation
        class Case
          attr_reader :end

          def initialize(bloc)
            @evalue = bloc
            @end = nil
          end

          def when(*pattern, &)
            pattern.lazy.map(&@evalue).compact.first&.then do |m|
              @end = yield m
              instance_exec do
                def when(*, &) = self
                def else(&) = self
              end
            end
            self
          end

          def else(&)
            @end = yield
            self
          end
        end
      end
      refine ::String do
        # case matching method
        def case(&bloc)
          if block_given?
            Impl::Case.new(bloc.curry[self])
          else
            self.case { |str, arg| arg.match(str) }
          end
        end
      end
    end
  end
end
