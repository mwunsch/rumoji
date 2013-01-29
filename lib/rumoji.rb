# -*- encoding: utf-8 -*-
require "rumoji/version"
require "rumoji/emoji"
require 'stringio'

module Rumoji
  extend self

  def encode(str)
    remapped_codepoints = str.codepoints.flat_map do |codepoint|
      emoji = Emoji.find_by_codepoint(codepoint)
      emoji ? ":#{emoji.code}:".codepoints.entries : codepoint
    end
    remapped_codepoints.pack("U*")
  end

  def decode(str)
    str.gsub(/:(\w+):/) {|sym| Emoji.find($1.intern).to_s }
  end

  def encode_io(readable, writeable=StringIO.new(""))
    readable.each_codepoint do |codepoint|
      emoji = Emoji.find_by_codepoint(codepoint)
      emoji_or_character = emoji ? ":#{emoji.code}:" : [codepoint].pack("U")
      writeable.write emoji_or_character
    end
    writeable
  end

  def decode_io(readable, writeable=StringIO.new(""))
    readable.each_line do |line|
      writeable.write line.gsub(/:(\w+):/) {|sym| Emoji.find($1.intern).to_s }
    end
    writeable
  end

  def codepoint_as_hex(codepoint)
    codepoint.to_s(16).upcase
  end

end
