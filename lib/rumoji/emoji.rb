# -*- encoding: utf-8 -*-
module Rumoji
  class Emoji

    attr_reader :name, :string

    def initialize(string, symbols, name = nil)
      @string = string
      @codepoints = string.unpack("U*")
      @cheat_codes = [symbols].flatten
      @name = name || @cheat_codes.first.to_s.upcase.gsub("_", " ")
    end

    def symbol
      symbols.first
    end

    def symbols
      @cheat_codes
    end

    def code
      ":#{symbol}:"
    end

    def include?(symbol)
      symbols.map(&:to_s).include? symbol.to_s
    end

    def to_s
      @string
    end

    def hash
      code.hash
    end

    def hex
      @hex ||= @codepoints.map{|point| point.to_s(16).upcase }.join("-")
    end

    def codepoints
      @codepoints.entries
    end

    def multiple?
      codepoints.size > 1
    end

    # Sort by reverse alphabetical order so that longer more complex emoji are
    # matched in the regex before their simpler components
    # e.g. :man-man-boy: needs to come before :man: in the regex or else
    # :man-man-boy: will never be matched
    def <=>(other)
      other.symbol.to_s <=> symbol.to_s
    end

    autoload :PEOPLE, 'rumoji/emoji/people'
    autoload :NATURE, 'rumoji/emoji/nature'
    autoload :OBJECTS, 'rumoji/emoji/objects'
    autoload :PLACES, 'rumoji/emoji/places'
    autoload :SYMBOLS, 'rumoji/emoji/symbols'

    ALL = PEOPLE | NATURE | OBJECTS | PLACES | SYMBOLS
    
    ALL_REGEXP = Regexp.new(ALL.map(&:string).join('|'))

    SYMBOL_LOOKUP = {}.tap do |lookup|
      ALL.each do |emoji|
        emoji.symbols.each do |symbol|
          lookup[symbol.to_s] = emoji
        end
      end
    end

    def self.find(symbol)
      SYMBOL_LOOKUP[symbol.to_s]
    end

    STRING_LOOKUP = {}.tap do |lookup|
      ALL.each do |emoji|
        lookup[emoji.string] = emoji
      end
    end

    def self.find_by_string(string)
      STRING_LOOKUP[string]
    end
  end
end
