# frozen_string_literal: true

require "rspec/expectations"
require "july/string/case"

RSpec.describe July::String::Case do
  using described_class
  describe "String#case" do
    describe "not matched" do
      context "when only case" do
        it "is nil" do
          expect("".case.end).to be_nil
        end
      end

      context "without else" do
        it "is nil" do
          expect("".case.when(/a/, &:to_s).end).to be_nil
        end
      end
    end

    describe "matched to 'abcde'" do
      subject(:with) { str.case.when(*regexp, &:to_s).end }

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

    describe "match when x 2 and else" do
      subject(:obj) do
        str.case
           .when(*regexp[0], &:to_s)
           .when(*regexp[1], &:to_s)
           .else { "else!" }
           .end
      end

      let(:str) { "abcde" }

      context "when match 1st" do
        let(:regexp) do
          [
            [/a/],
            [/1/]
          ]
        end

        it "is 'a'" do
          expect(obj).to eq "a"
        end
      end

      context "when match 2nd" do
        let(:regexp) do
          [
            [/1/],
            [/a/]
          ]
        end

        it "is 'a'" do
          expect(obj).to eq "a"
        end
      end
    end
  end
end
