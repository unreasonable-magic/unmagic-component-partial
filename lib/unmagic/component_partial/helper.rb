# frozen_string_literal: true

module Unmagic
  module ComponentPartial
    # The view helper. Mixed into ActionView by the railtie, so every template
    # can call `component_partial`.
    module Helper
      def component_partial
        Partial.new(self)
      end
    end
  end
end
