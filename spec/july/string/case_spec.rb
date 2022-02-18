# frozen_string_literal: true

require "july/string/case"
RSpec.describe July::String::Case do
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

    describe "match when x 2 and else" do
      subject(:obj) do
        str.case
           .when(*regexp[0]){_2.to_s}
           .when(*regexp[1]){_2.to_s}
           .else{_1}
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
