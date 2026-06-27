# unmagic-component-partial

Named slots for Rails partials rendered as layouts.

Rails partials have one body (the block you pass to `render layout:`). That's
fine until a component needs content in more than one place — a card with a body
*and* a footer, a panel with a header actions row *and* a body. The usual
workarounds (a second partial, a `content_for` global, a pile of locals carrying
pre-rendered HTML) all leak the component's structure to the caller.

This gem gives a partial **named slots**, after Dom Christie's
[Component partials](https://domchristie.co.uk/posts/component-partials/). The
caller fills slots inline; the partial reads them back wherever it likes.

## Install

```ruby
# Gemfile
gem "unmagic-component-partial"
```

The railtie mixes the `component_partial` helper into ActionView automatically —
no initializer.

## Usage

Render the partial as a layout. The block is the body, and is yielded a handle
you fill slots on:

```erb
<%= render layout: "shared/card", locals: { title: "Profile" } do |card| %>
  ...the card body...

  <% card.content_for :footer do %>
    <%= form.submit "Save" %>
  <% end %>
<% end %>
```

Inside the partial, grab a handle with `component_partial`, render the body with
`yield`, and read slots back where they belong:

```erb
<%# app/views/shared/_card.html.erb %>
<% partial = component_partial %>
<section class="card">
  <div class="card__body">
    <%= yield partial %>
  </div>

  <% if partial.content_for(:footer) %>
    <footer class="card__footer">
      <%= partial.content_for(:footer) %>
    </footer>
  <% end %>
</section>
```

The body block and the slot blocks are the *same* block, so the slots see the
caller's locals and helpers exactly as the body does.

## API

- `component_partial` — returns a fresh `Partial` bound to the current view.
- `Partial#content_for(name, content = nil, &block)`:
  - with a string or block, **writes** the slot (successive writes to the same
    slot append), and returns `nil`;
  - with no content, **reads** the slot back, or `nil` if it was never set.

## License

MIT
