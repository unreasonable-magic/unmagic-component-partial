# frozen_string_literal: true

RSpec.describe Unmagic::ComponentPartial::Helper do
  subject(:view) { Class.new { include Unmagic::ComponentPartial::Helper }.new }

  it "builds a Partial bound to the view context" do
    expect(view.component_partial).to be_a(Unmagic::ComponentPartial::Partial)
  end

  it "builds a fresh Partial each call" do
    expect(view.component_partial).not_to equal(view.component_partial)
  end
end
