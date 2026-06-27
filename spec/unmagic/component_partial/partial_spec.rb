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
end
