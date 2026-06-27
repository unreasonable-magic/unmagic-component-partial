# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0]

### Added
- `component_partial` view helper and the `Partial` slot handle — render a
  partial as a layout, yield it a handle, and fill named slots the partial reads
  back wherever it likes (a card footer, a header actions row).
- Rails integration: a railtie mixes the helper into ActionView, so every
  template can call `component_partial` with no setup.
