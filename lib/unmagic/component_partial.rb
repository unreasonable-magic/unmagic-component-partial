# frozen_string_literal: true

require_relative "component_partial/version"
require_relative "component_partial/partial"
require_relative "component_partial/helper"
require_relative "component_partial/railtie" if defined?(Rails::Railtie)

# Component-partial slots, after Dom Christie's "Component partials"
# (https://domchristie.co.uk/posts/component-partials/).
#
# Render a partial as a layout and yield it a Partial object. The block fills
# named slots that the partial reads back wherever it likes — handy for content
# that isn't the main body, e.g. a card footer:
#
#   <%= render layout: "shared/card" do |card| %>
#     ...body...
#     <% card.content_for :footer do %><%= form.submit %><% end %>
#   <% end %>
#
# and in the partial: `<%= partial.content_for(:footer) %>`, where
# `partial = component_partial`.
module Unmagic
  module ComponentPartial
  end
end
