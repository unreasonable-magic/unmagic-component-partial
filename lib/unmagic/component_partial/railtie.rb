# frozen_string_literal: true

module Unmagic
  module ComponentPartial
    # Rails integration: make `component_partial` available in every template.
    class Railtie < ::Rails::Railtie
      initializer "unmagic.component_partial.helper" do
        ActiveSupport.on_load(:action_view) do
          include Unmagic::ComponentPartial::Helper
        end
      end
    end
  end
end
