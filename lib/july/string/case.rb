# frozen_string_literal: true

require "july"
module July
  module String
    # refinement module for case matching
    module Case
      # implementation classes
      module Impl
        # case implementation
        class Case
          attr_accessor :actions

          def initialize(bloc)
            @eval = bloc
            @actions = []
          end

          def when(*pattern, &action)
            raise July::UnexpectedMethodCall.new, "unexpected 'when'" if defined_else?
            raise ArgumentError.new, "needs to pass block" unless block_given?

            @actions.push({ type: :when, pattern:, action: })
            self
          end

          def else(&action)
            raise July::UnexpectedMethodCall.new, "unexpected 'else'" if defined_else?
            raise ArgumentError.new, "needs to pass block" unless block_given?

            @actions.push({ type: :else, action: })
            self
          end

          def end = detect_action&.then(&:call)

          def defined_else? = @actions.last&.fetch(:type) == :else

          private

          def evaluete(pattern) = pattern.lazy.map(&@eval).compact.first

          def detect_action
            @actions.lazy.map do |elm|
              case elm
              in {type: :when, pattern:, action: }
                evaluete(pattern)&.then { |m| proc { action&.call(m) } }
              in {type: :else, action:}
                action
              else
                nil
              end
            end.compact.first
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
