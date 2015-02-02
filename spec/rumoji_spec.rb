# -*- encoding: utf-8 -*-
require 'rumoji'
require 'minitest/spec'
require 'minitest/autorun'

describe Rumoji do
  before do
    @poop = "💩"
    @smile = "😄"
    @non_potable_water = "🚱"
  end

  describe "#encode" do
    it "transforms emoji into cheat-sheet form" do
      key = :smile
      Rumoji.encode(@smile).must_equal ":smile:"
      Rumoji.encode("#{@smile}").must_equal ":smile:"
    end
  end

  describe "#decode" do
    it "transforms a cheat-sheet code into an emoji" do
      Rumoji.decode(":poop:").must_equal @poop
    end

    it "transforms a cheat-sheet code into an emoji with colon" do
      Rumoji.decode("::poop:").must_equal ':' + @poop
    end

    it "transforms a cheat-sheet code with a dash into an emoji" do
      Rumoji.decode(":non-potable_water:").must_equal @non_potable_water
    end
  end

  describe "#encode_io" do
    it "reads emoji from one stream and outputs a stream of cheat-sheet codes" do
      io = StringIO.new("#{@smile}")
      Rumoji.encode_io(io).string.must_equal ":smile:"
    end

    it "keeps codepoints that match the beginnings of multi-codepoint emoji" do
      text = "i like #hashtags and 1direction they are the #1 band. end with 9"
      io   = StringIO.new(text)
      Rumoji.encode_io(io).string.must_equal text
    end
  end

  describe "#decode_io" do
    it "reads a cheat-sheet code from one stream and outputs a stream of emoji" do
      io = StringIO.new(":poop:")
      Rumoji.decode_io(io).string.must_equal @poop
    end
  end
end
