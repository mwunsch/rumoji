# -*- encoding: utf-8 -*-
require 'rumoji'
require 'minitest/spec'
require 'minitest/autorun'

describe Rumoji::Emoji do
  let(:symbols) { [:hankey, :poop, :shit] }
  let(:emoji_name) { "PILE OF POO" }
  let(:poo_string) { "\u{1F4A9}" }

  subject do 
    Rumoji::Emoji.new(poo_string, symbols, emoji_name)
  end

  it("has a name") { subject.name.must_equal emoji_name }
  it("has a cheat sheet code") { symbols.must_include subject.code[1...-1].intern } 
  it("can test if it includes a cheat sheet code") { symbols.all?{|symbol| subject.include?(symbol) }.must_equal true }
  it("converts to the emoji string") { subject.to_s.must_equal poo_string }
  it("converts to a hex code") { subject.hex.must_equal "1F4A9" }

  describe "inferring the name" do
    let (:symbol) { :person_with_pouting_face }
    subject do
      Rumoji::Emoji.new("\u{1F64E}", symbol)
    end

    it("infers the name from the symbol") { subject.name.must_equal "PERSON WITH POUTING FACE" }
  end

  describe "with multiple codepoints" do
    # From the Unicode 6.2.0 standard:
    #   The regional indicator symbols in the range
    #   U+1F1E6..U+1F1FF can be used in pairs to represent an ISO 3166 region code. 
    #   This mechanism is not intended to supplant actual ISO 3166 region codes, 
    #   which simply use Latin letters in the ASCII range; instead the main purpose 
    #   of such pairs is to provide unambiguous roundtrip mappings to certain 
    #   characters used in the emoji core sets. The representative glyph for 
    #   region indicator symbols is simply a dotted box containing a letter. The 
    #   Unicode Standard does not prescribe how the pairs of region indicator 
    #   symbols should be rendered. In emoji contexts, where text is displayed 
    #   as it would be on a Japanese mobile phone, a pair may be displayed using 
    #   the glyph for a flag, as appropriate, but in other contexts the pair
    #   could be rendered differently
    #
    # http://www.unicode.org/versions/Unicode6.2.0/
    let(:symbol) { :us }
    let(:emoji_name) { "REGIONAL INDICATOR SYMBOL LETTERS US" }
    let(:us_string) { "\xF0\x9F\x87\xBA\xF0\x9F\x87\xB8" }

    subject do 
      Rumoji::Emoji.new(us_string, symbol, emoji_name)
    end

    it("has one symbol, representing the code") { subject.symbol.must_equal symbol }
    it("has one cheat sheet code") { subject.code[1...-1].intern.must_equal symbol }
    it("includes the symbol") { subject.must_include symbol }
    it("transforms to the correct string") { subject.to_s.must_equal us_string }
  end

  describe "factory methods" do
    subject { Rumoji::Emoji }
    let(:smile_str) { "\u{1F604}" }
    let(:smile_sym) { :smile }

    it "finds an emoji from cheat sheet code" do
      subject.find(smile_sym).to_s.must_equal smile_str
    end

    it "finds an emoji from a string" do
      subject.find_by_string(smile_str).symbol.must_equal smile_sym
    end

    it "finds an emoji from a codepoint" do
      smile_str.codepoints.map do |point|
        subject.find_by_codepoint(point).symbol.must_equal smile_sym
      end
    end
  end

end
