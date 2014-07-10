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
    str.gsub(/:([^s:]?[\w-]+):/) {|sym| Emoji.find($1.intern).to_s }
  end

  def encode_io(readable, writeable=StringIO.new(""))
    previous_codepoints = []

    readable.each_codepoint do |codepoint|
      possible_emoji = Emoji.select_by_codepoint(codepoint)

      sequence =  if possible_emoji.empty?
                    # If this codepoint is not part of an emoji
                    # just write it back out, along with any previously stored codepoints.
                    dump_codepoints_to_string(previous_codepoints << codepoint)
                  elsif !possible_emoji.any?(&:multiple?)
                    # If this codepoint is part of an emoji, but not one
                    # that contains multiple codepoints, write out the
                    # first possiblity's cheat code and the previously stored codepoints
                    dump_codepoints_to_string(previous_codepoints) << possible_emoji.first.code
                  else
                    # This codepoint is a part of an emoji with multiple
                    # codepoints, so push it onto the stack.
                    previous_codepoints.push(codepoint)
                    # Check and see if this completes the emoji, otherwise,
                    # write out an empty string.
                    if found = possible_emoji.find {|e| e.codepoints.eql?(previous_codepoints) }
                      previous_codepoints.clear and found.code
                    else
                      ""
                    end
                  end

      writeable.write sequence
    end

    # Write any remaining codepoints.
    writeable.write dump_codepoints_to_string(previous_codepoints) if previous_codepoints.any?

    writeable
  end

  def decode_io(readable, writeable=StringIO.new(""))
    readable.each_line do |line|
      writeable.write decode(line)
    end
    writeable
  end

private

  def dump_codepoints_to_string(codepoints)
    codepoints.pack("U*").tap do
      codepoints.clear
    end
  end

end
