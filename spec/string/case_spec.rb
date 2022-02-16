# frozen_string_literal: true

require "string/case"
RSpec.describe Case do
  using Case
  it "is nil" do
    expect("".case {}).to eq nil
  end

  it "is match /a/" do
    expect("abcde".case.when(/a/) {_2.to_s}).to eq "a"
  end
end
