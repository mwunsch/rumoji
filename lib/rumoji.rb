# coding: utf-8
require 'stringio'
require 'yaml'

module Rumoji
  VERSION = '0.4.1'

  ALL = Dir["#{File.dirname(__FILE__)}/rumoji/*.yml"].map do |file|
    const = self.const_set(File.basename(file, '.yml').upcase, {})
    YAML.load_file(file).each { |k, v| const[k.to_s] = v }
    const
  end.inject(:merge)

  class << self

    # Transform emoji into its cheat-sheet code
    def encode(str)
      io = StringIO.new(str)
      encode_io(io).string
    end

    # Transform a cheat-sheet code into an Emoji
    def decode(str)
      str.gsub(/:([^s:]?[\w-]+):/) { |sym| ALL[$1] }
    end

    def encode_io(readable, writeable=StringIO.new(''))
      readable.each do |c|
        emoji = ALL.key c
        if emoji then writeable.write ":#{emoji}:" else writeable.write c end
      end
      writeable
    end

    def decode_io(readable, writeable=StringIO.new(''))
      readable.each_line do |line|
        writeable.write decode(line)
      end
      writeable
    end
  end
end
