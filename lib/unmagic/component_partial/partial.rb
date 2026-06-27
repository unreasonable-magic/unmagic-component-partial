# frozen_string_literal: true

require "active_support/core_ext/string/output_safety"
require "active_support/core_ext/object/blank"

module Unmagic
  module ComponentPartial
    # A handle yielded to the block of a partial rendered as a layout. The block
    # fills named slots; the partial reads them back wherever it likes — for
    # content that isn't the main body, e.g. a card footer.
    class Partial
      def initialize(view_context)
        @view_context = view_context
        @contents = Hash.new { |h, k| h[k] = ActiveSupport::SafeBuffer.new }
      end

      # Write a slot (string or block), or read it back when called without
      # content. Reading an unset slot returns nil.
      def content_for(name, content = nil, &block)
        if content || block
          content = @view_context.capture(&block) if block
          @contents[name] << content.to_s
          nil
        else
          @contents[name].presence
        end
      end
    end
  end
end
