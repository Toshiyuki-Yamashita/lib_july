# frozen_string_literal: true

require "string/case"
RSpec.describe Case do
  using described_class
  describe "String#case" do
    describe "not matched" do
      context "when only case" do
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
      subject(:with) { str.case.when(*regexp) {_2.to_s } }

      describe "#when /a/" do
        let(:str) { "abcde" }
        let(:regexp) { [/a/] }

        it "is 'a'" do
          expect(with).to eq "a"
        end
      end

      describe "#when /a/,/b/" do
        let(:str) { "abcde" }
        let(:regexp) { [/a/, /b/] }

        it "is 'a'" do
          expect(with).to eq "a"
        end
      end
    end
  end
end
