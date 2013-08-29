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
    codepoints = readable.each_codepoint
    previous_emoji = []

    codepoints.each_with_object(writeable) do |codepoint, writer|
      possible_emoji = Emoji.select_by_codepoint(codepoint)
      last_emoji = previous_emoji.pop

      sequence =  if last_emoji.nil? || !last_emoji.codepoints.include?(codepoint)
                    if possible_emoji.empty?
                      last_codepoint = last_emoji && last_emoji.codepoints.first
                      sequence_codepoints = [last_codepoint, codepoint].compact
                      sequence_codepoints.pack("U" * sequence_codepoints.size)
                    else
                      multiple_codepoint_emoji = possible_emoji.select(&:multiple?)
                      if multiple_codepoint_emoji.empty?
                        possible_emoji.first.code
                      else
                        previous_emoji.concat(multiple_codepoint_emoji) ; ""
                      end
                    end
                  else
                    last_emoji.code
                  end

      writer.write sequence
    end
  end

  def decode_io(readable, writeable=StringIO.new(""))
    readable.each_line do |line|
      writeable.write decode(line)
    end
    writeable
  end

private


end
