# Ruby 1.8 don't understand unicode string as "\u{1F38D}"
# We use this script to convert unicode string to unicode character in file
# This script can be run in Ruby 1.8.7

class UpdateEmojiSet
  attr_reader :file_paths

  def initialize(file_paths)
    @file_paths = file_paths
  end
  
  def perform
    file_paths.each do |file_path|
      text = File.read(file_path)
      
      new_contents = text.gsub(/"\\u\{(.+)\}"/) do |match|
        %Q{"#{$1.to_s.split(" ").map{ |c| c.to_i(16) }.pack("U*")}"}
      end

      File.open(file_path, "w") {|file| file.puts new_contents }
    end
  end
end

UpdateEmojiSet.new([
  "lib/rumoji/emoji/nature.rb",
  "lib/rumoji/emoji/objects.rb",
  "lib/rumoji/emoji/people.rb",
  "lib/rumoji/emoji/places.rb",
  "lib/rumoji/emoji/symbols.rb"
]).perform