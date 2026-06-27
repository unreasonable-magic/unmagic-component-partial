# frozen_string_literal: true

require_relative "lib/unmagic/component_partial/version"

Gem::Specification.new do |spec|
  spec.name        = "unmagic-component-partial"
  spec.version     = Unmagic::ComponentPartial::VERSION
  spec.authors     = [ "Keith Pitt" ]
  spec.email       = [ "keith@unreasonable-magic.com" ]
  spec.summary     = "Named slots for Rails partials rendered as layouts"
  spec.description = "Render a partial as a layout and yield it a handle whose named slots the block fills and the partial reads back wherever it likes — for content that isn't the main body, like a card footer or a header actions row."
  spec.homepage    = "https://github.com/unreasonable-magic/unmagic-component-partial"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "README.md", "LICENSE", "CHANGELOG.md"]
  spec.require_paths = [ "lib" ]

  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "actionview", ">= 7.0"

  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rake", "~> 13.0"
end
