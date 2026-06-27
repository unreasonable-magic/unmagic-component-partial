# frozen_string_literal: true

require "active_support/core_ext/string/output_safety"
require "active_support/core_ext/object/blank"

module Unmagic
  module ComponentPartial
    # A handle yielded to the block of a partial rendered as a layout. The block
    # fills named slots; the partial reads them back wherever it likes — for
    # content that isn't the main body, e.g. a card footer. A slot can also
    # carry props: structured data the partial reads back with #props_for.
    class Partial
      def initialize(view_context)
        @view_context = view_context
        @contents = Hash.new { |h, k| h[k] = ActiveSupport::SafeBuffer.new }
        @props = {}
      end

      # Write a slot (string or block, with optional props), or read it back
      # when called with nothing. Reading an unset slot returns nil.
      def content_for(name, content = nil, **props, &block)
        if content || block || props.any?
          content = @view_context.capture(&block) if block
          @contents[name] << content.to_s
          (@props[name] ||= {}).merge!(props) if props.any?
          nil
        else
          @contents[name].presence
        end
      end

      # Read the props attached to a slot, or an empty hash when none were set.
      def props_for(name)
        @props[name] || {}
      end
    end
  end
end
