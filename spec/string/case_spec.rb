# frozen_string_literal: true

require "string/case"
RSpec.describe String do
  using Case
  describe "#case" do
    describe "not matched" do
      context "only case" do
        it "is nil" do
          expect("".case).to eq nil
        end
      end
      context "without else" do
        it "is nil" do
          expect("".case.when(/a/){_2.to_s}).to eq nil
        end
      end
    end
    describe "matched to 'abcde'" do
      subject { str.case.when(*regexp){_2.to_s} }
      context "#when /a/" do
        let(:str) { "abcde" }
        let(:regexp) { [/a/] }
        it "is 'a'" do
          is_expected.to eq "a"
        end
      end
      context "#when /a/,/b/" do
        let(:str) { "abcde" }
        let(:regexp) { [/a/, /b/] }
        it "is 'a'" do
          expect("abcde".case.when(/a/, /b/) {_2.to_s}).to eq "a"
        end
      end
    end
  end
end
