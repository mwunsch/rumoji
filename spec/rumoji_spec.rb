# -*- encoding: utf-8 -*-
require 'rumoji'
require 'minitest/spec'
require 'minitest/autorun'

describe Rumoji do
  before do
    @poop = "💩"
    @smile = "😄"
    @emoji_symbols = "0⃣1⃣2⃣3⃣4⃣5⃣6⃣7⃣8⃣9⃣#⃣"
    @cheat_sheet_symbols = ":zero::one::two::three::four::five::six::seven::eight::nine::hash:"
  end

  describe "#encode" do
    it "transforms emoji into cheat-sheet form" do
      key = :smile
      Rumoji.encode(@smile).must_equal ":smile:"
    end

    it "transforms emoji with associated ASCII versions into cheat-sheet form" do
      Rumoji.encode(@emoji_symbols).must_equal @cheat_sheet_symbols
    end

    it "does not transform ASCII-symbol-versions of emoji into cheat-sheet form" do
      ascii_symbols = "0123456789#"
      Rumoji.encode(ascii_symbols).must_equal ascii_symbols
    end
  end

  describe "#decode" do
    it "transforms a cheat-sheet code into an emoji" do
      Rumoji.decode(":poop:").must_equal @poop
    end

    it "transforms cheat-sheet codes into emoji even when there are associated ASCII versions" do
      Rumoji.decode(@cheat_sheet_symbols).must_equal @emoji_symbols
    end
  end

  describe "#encode_io" do
    it "reads emoji from one stream and outputs a stream of cheat-sheet codes" do
      io = StringIO.new("#{@smile}")
      Rumoji.encode_io(io).string.must_equal ":smile:"
    end
  end

  describe "#decode_io" do
    it "reads a cheat-sheet code from one stream and outputs a stream of emoji" do
      io = StringIO.new(":poop:")
      Rumoji.decode_io(io).string.must_equal @poop
    end
  end
end
