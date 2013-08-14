# -*- encoding: utf-8 -*-
require "rumoji/version"
require "rumoji/emoji"
require 'stringio'

module Rumoji
  extend self

  # Transform emoji into its cheat-sheet code
  def encode(str)
    new_str = ""

    str.scan(/.\u20e3?/) do |str|
      emoji = Emoji.find_by_string(str)
      new_str << (emoji ? emoji.code : str)
    end

    new_str
  end

  # Transform a cheat-sheet code into an Emoji
  def decode(str)
    str.gsub(/:(\S?\w+):/) {|sym| Emoji.find($1.intern).to_s }
  end

  def encode_io(readable, writeable=StringIO.new(""))
    readable.each_codepoint do |codepoint|
      emoji = Emoji.find_by_codepoint(codepoint)
      emoji_or_character = emoji ? emoji.code : [codepoint].pack("U")
      writeable.write emoji_or_character
    end
    writeable
  end

  def decode_io(readable, writeable=StringIO.new(""))
    readable.each_line do |line|
      writeable.write decode(line)
    end
    writeable
  end

end
