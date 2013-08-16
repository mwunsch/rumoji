# -*- encoding: utf-8 -*-
require "rumoji/version"
require "rumoji/emoji"
require 'stringio'

module Rumoji
  extend self

  # Transform emoji into its cheat-sheet code
  def encode(str)
    io = StringIO.new(str)
    encode_io(io).string
  end

  # Transform a cheat-sheet code into an Emoji
  def decode(str)
    str.gsub(/:(\S?\w+):/) {|sym| Emoji.find($1.intern).to_s }
  end

  def encode_io(readable, writeable=StringIO.new(""))
    codepoints = readable.each_codepoint.entries
    codepoints.each_with_index do |codepoint, index|
      possible_emoji = Emoji.select_by_codepoint(codepoint)
      sequence = if possible_emoji.empty?
        [codepoint].pack("U")
      elsif possible_emoji.size.eql?(1)
        possible_emoji.first.code
      else
        find_multipoint_emoji_in_set(possible_emoji, codepoints[index + 1])
      end
      writeable.write sequence
    end
    writeable
  end

  def decode_io(readable, writeable=StringIO.new(""))
    readable.each_line do |line|
      writeable.write decode(line)
    end
    writeable
  end

private

  def find_multipoint_emoji_in_set(possible_emoji_set, next_codepoint)
    if next_codepoint
      emoji_or_nil = possible_emoji_set.find {|emoji| emoji.codepoints.include?(next_codepoint) }
      emoji_or_nil.nil? ? "" : emoji_or_nil.code
    end
  end

end
