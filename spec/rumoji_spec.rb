# -*- encoding: utf-8 -*-
require 'rumoji'
require 'minitest/spec'
require 'minitest/autorun'

describe Rumoji do
  before do
    @poop = "💩"
    @smile = "😄"
  end

  describe "#encode" do
    it "transforms emoji into cheat-sheet form" do
      key = :smile
      Rumoji.encode(@smile).must_equal ":smile:"
    end
  end

  describe "#decode" do
    it "transforms a cheat-sheet code into an emoji" do
      Rumoji.decode(":poop:").must_equal @poop
    end
  end

  describe "#encode_io" do
    it "reads emoji from one stream and outputs a stream of cheat-sheet codes" do
      io = StringIO.new("#{@smile}")
      Rumoji.encode_io(io).read.must_equal ":smile:"
    end
  end

  describe "#decode_io" do
    it "reads a cheat-sheet code from one stream and outputs a stream of emoji" do
      io = StringIO.new(":poop:")
      Rumoji.decode_io(io).read.must_equal @poop
    end
  end
end