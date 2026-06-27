# frozen_string_literal: true

# A stand-in for the view context. ActionView's `capture` runs the block and
# returns its rendered output; here the block returns its own string.
class FakeView
  def capture
    yield
  end
end

RSpec.describe Unmagic::ComponentPartial::Partial do
  subject(:partial) { described_class.new(FakeView.new) }

  it "reads an unset slot as nil" do
    expect(partial.content_for(:footer)).to be_nil
  end

  it "writes and reads back a string" do
    expect(partial.content_for(:footer, "Save")).to be_nil
    expect(partial.content_for(:footer)).to eq("Save")
  end

  it "captures block content through the view context" do
    partial.content_for(:footer) { "Cancel" }
    expect(partial.content_for(:footer)).to eq("Cancel")
  end

  it "appends successive writes to the same slot" do
    partial.content_for(:footer, "A")
    partial.content_for(:footer, "B")
    expect(partial.content_for(:footer)).to eq("AB")
  end

  it "keeps slots independent" do
    partial.content_for(:header, "Title")
    partial.content_for(:footer, "Actions")
    expect(partial.content_for(:header)).to eq("Title")
    expect(partial.content_for(:footer)).to eq("Actions")
  end

  it "returns a SafeBuffer so output is not re-escaped" do
    partial.content_for(:footer, "<b>x</b>".html_safe)
    expect(partial.content_for(:footer)).to be_html_safe
  end

  it "reads props from an unset slot as an empty hash" do
    expect(partial.props_for(:footer)).to eq({})
  end

  it "stores content and props written together" do
    partial.content_for(:footer, align: :right) { "Save" }
    expect(partial.content_for(:footer)).to eq("Save")
    expect(partial.props_for(:footer)).to eq(align: :right)
  end

  it "accepts a props-only write with no content or block" do
    expect(partial.content_for(:footer, align: :right)).to be_nil
    expect(partial.content_for(:footer)).to be_nil
    expect(partial.props_for(:footer)).to eq(align: :right)
  end

  it "merges props across successive writes, last key winning" do
    partial.content_for(:footer, a: 1)
    partial.content_for(:footer, b: 2, a: 3)
    expect(partial.props_for(:footer)).to eq(a: 3, b: 2)
  end

  it "reads a bare slot without hitting the write branch" do
    expect(partial.content_for(:footer)).to be_nil
    expect(partial.props_for(:footer)).to eq({})
  end

  it "keeps props independent across slots" do
    partial.content_for(:header, level: 1)
    partial.content_for(:footer, align: :right)
    expect(partial.props_for(:header)).to eq(level: 1)
    expect(partial.props_for(:footer)).to eq(align: :right)
  end
end
