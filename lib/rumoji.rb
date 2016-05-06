# -*- encoding: utf-8 -*-
require "rumoji/version"
require "rumoji/emoji"
require 'stringio'

module Rumoji
  extend self

  # Transform emoji into its cheat-sheet code
  def encode(str)
    str.gsub(Emoji::ALL_REGEXP) { |match| (emoji = Emoji.find_by_string(match)) && emoji.code || match }
  end

  # Transform a cheat-sheet code into an Emoji
  def decode(str)
    str.gsub(/:([^\s:]?[\w-]+):/) { |match| (Emoji.find($1) || match).to_s }
  end

  def encode_io(readable, writeable=StringIO.new(""))
    readable.each_line do |line|
      writeable.write encode(line)
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
