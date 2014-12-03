# -*- encoding: utf-8 -*-
require 'rumoji'
require 'minitest/spec'
require 'minitest/autorun'

describe Rumoji do
  before do
    @poop = "💩"
    @smile = "😄"
    @zero = "0️⃣"
    @us = "🇺🇸"
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
    
    it "does not transform an arbitrary string wrapped in colons" do
      Rumoji.decode(":this-is-just-a-string:").must_equal ":this-is-just-a-string:"
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

    describe "with multiple codepoints" do
      it "transforms a stream" do
        io1 = StringIO.new("#{@zero}")
        io2 = StringIO.new("#{@us}")
        Rumoji.encode_io(io1).string.must_equal ":zero:"
        Rumoji.encode_io(io2).string.must_equal ":us:"
      end

      it "transforms a stream of many emoji" do
        num = ":one: :two: :three: :four: :five: :six: :seven: :eight: :nine: :zero: :hash:"
        emoji = StringIO.new"1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ 0️⃣ #️⃣"
        Rumoji.encode_io(emoji).string.must_equal num
      end

      it "does not encode double digits" do
        num = ":zero: :one: :two: :three: :four: :five: :six: :seven: :eight: :nine: :hash:"
        double_digits = StringIO.new("00 11 22 33 44 55 66 77 88 99 ##")
        Rumoji.encode_io(double_digits).string.wont_equal num
      end

      describe "with leading and trailing characters" do
        it "is able to pull multipoint emoji out of a sequence" do
          io = StringIO.new("An example of a multipoint emoji is the #{@us} flag.")
          Rumoji.encode_io(io).string.must_equal "An example of a multipoint emoji is the :us: flag."
        end
      end

      describe "with trailing emoji" do
        it "writes characters that are in a multipoint emoji followed by an emoji" do
          io = StringIO.new "I would like 0#{@poop}"
          Rumoji.encode_io(io).string.must_equal "I would like 0:poop:"
        end
      end
    end

  end

  describe "#decode_io" do
    it "reads a cheat-sheet code from one stream and outputs a stream of emoji" do
      io = StringIO.new(":poop:")
      Rumoji.decode_io(io).string.must_equal @poop
    end

    describe "with multiple codepoints" do
      it "decodes a stream" do
        io = StringIO.new(":zero:")
        Rumoji.decode_io(io).string.must_equal @zero
      end
    end
  end
end
