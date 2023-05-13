# frozen_string_literal: true

module RuboCop
  module Cop
    module Hc
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      #
      class RailsSpecificActionName < Base
        include VisibilityHelp

        MSG = 'Use only specific action names.'

        # @param node [RuboCop::AST::DefNode]
        # @return [void]
        def on_def(node)
          return unless bad?(node)

          add_offense(
            node.location.name,
            message: format(
              'Use only specific action names (%<action_names>s).',
              action_names: configured_action_names.join(', ')
            )
          )
        end

        private

        # @param node [RuboCop::AST::DefNode]
        # @return [Boolean]
        def action?(node)
          node_visibility(node) == :public
        end

        # @param node [RuboCop::AST::DefNode]
        # @return [Boolean]
        def bad?(node)
          action?(node) &&
            !configured_action_name?(node)
        end

        # @param node [RuboCop::AST::DefNode]
        # @return [Boolean]
        def configured_action_name?(node)
          configured_action_names.include?(node.method_name.to_s)
        end

        # @return [Array<String>]
        def configured_action_names
          cop_config['ActionNames']
        end
      end
    end
  end
end
