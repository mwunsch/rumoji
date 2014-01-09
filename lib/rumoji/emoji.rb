# -*- encoding: utf-8 -*-
module Rumoji
  class Emoji

    attr_reader :name

    def initialize(string, symbols, name = nil)
      @codepoints = string.codepoints
      @cheat_codes = [symbols].flatten
      @name = name || @cheat_codes.first.to_s.upcase.gsub("_", " ")
    end

    def symbol
      @cheat_codes.first
    end

    def code
      ":#{symbol}:"
    end

    def include?(symbol)
      @cheat_codes.include? symbol.to_sym
    end

    def to_s
      codepoints.pack("U*")
    end

    def hash
      code.hash
    end

    def hex
      @codepoints.map{|point| point.to_s(16).upcase }.join("-")
    end

    def codepoints
      @codepoints.entries
    end

    def multiple?
      codepoints.size > 1
    end

    autoload :PEOPLE, 'rumoji/emoji/people'
    autoload :NATURE, 'rumoji/emoji/nature'
    autoload :OBJECTS, 'rumoji/emoji/objects'
    autoload :PLACES, 'rumoji/emoji/places'
    autoload :SYMBOLS, 'rumoji/emoji/symbols'

    ALL = PEOPLE | NATURE | OBJECTS | PLACES | SYMBOLS

    def self.find(symbol)
      ALL.find {|emoji| emoji.include? symbol }
    end

    def self.find_by_string(string)
      ALL.find {|emoji| emoji.to_s == string }
    end

    def self.select_by_codepoint(codepoint)
      ALL.select {|emoji| emoji.codepoints.include? codepoint }
    end

    def self.find_by_codepoint(codepoint)
      ALL.find {|emoji| emoji.hex == codepoint.to_s(16).upcase }
    end

  end
end
