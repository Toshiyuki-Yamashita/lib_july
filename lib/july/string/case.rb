# frozen_string_literal: true

require "july"
module July
  # string  utility library for ruby
  module String
    # refinement module for case matching
    module Case
      # implementation classes
      module Impl
        # case implementation
        # @attr actions [Array<Hash<Symbol,Object>>]
        # @private
        class Case
          attr_accessor :actions

          # @yield [regexp] block  to evaluate
          # @yieldparam regexp [Regexp] regexp to be matched
          # @return [void]
          def initialize(&evaluate)
            @eval = evaluate
            @actions = []
          end

          # define match condition and action block as  {|m| ... }
          # @param [Array<Regexp>] pattern patterns to match
          # @yield  [m] action when matched
          # @yieldparam [MatchData] m return value of match
          # @return [self]
          def when(*pattern, &action)
            raise July::UnexpectedMethodCall.new, "unexpected 'when'" if defined_else?
            raise ArgumentError.new, "needs to pass block" unless block_given?

            @actions.push({ type: :when, pattern:, action: })
            self
          end

          # define default action block as { ... }
          # @yield  action for else closure
          # @return [self]
          def else(&action)
            raise July::UnexpectedMethodCall.new, "unexpected 'else'" if defined_else?
            raise ArgumentError.new, "needs to pass block" unless block_given?

            @actions.push({ type: :else, action: })
            self
          end

          # @return  return value of case statement if action is executed
          # @return nil if action is not executed
          def end = detect_action&.then(&:call)

          # @return [bool] wheather else is defined or not
          def defined_else? = @actions.last&.fetch(:type) == :else

          private

          # @private
          # evaluate string and regexp
          # @param pattern [Array<Regexp>] patterns to match
          # @return [MatchData] if one of patterns mached
          # @return [nil] if none of patterns  matched
          def evaluete(pattern) = pattern.lazy.map(&@eval).compact.first

          # @private
          # execute matching and evaluate action
          # @return [Object] return value of action
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
        # case matching method with evaluate block as {| me, arg| ... }
        # yield [me, arg] block case match evaluation
        # @yieldparam me [String] string to match
        # @yieldparam arg [Regexp] Regexp to be matched
        # @return [Impl::Case] case object
        def case(&)
          if block_given?
            Impl::Case.new { |regexp| yield self, regexp }
          else
            self.case { |str, arg| arg.match(str) }
          end
        end
      end
    end
  end
end
