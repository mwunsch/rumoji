# -*- encoding: utf-8 -*-
require 'rumoji'
require 'minitest/spec'
require 'minitest/autorun'

describe Rumoji do
  before do
    @emoji_map = Hash[Rumoji::EMOJI_NAME_TO_CODEPOINT.map {|k,v| [k, [v.to_i(16)].pack("U")] }]
  end

  describe "#encode" do
    it "transforms emoji into cheat-sheet form" do
      key = :smile
      Rumoji.encode("#{@emoji_map[key]}").must_equal ":#{key}:"
    end
  end

  describe "#decode" do
    it "transforms a cheat-sheet code into an emoji" do
      poop_emoji = "💩"
      Rumoji.decode(":poop:").must_equal "#{poop_emoji}"
    end
  end
end