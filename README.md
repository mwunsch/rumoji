# Rumoji

This is a tool to convert Emoji Unicode codepoints into the human-friendly codes used by http://www.emoji-cheat-sheet.com/ and back again.

Why would you want to do this? Read this blog post: http://mwunsch.tumblr.com/post/34721548842/we-need-to-talk-about-emoji

## tl;dr

>By doing this, you can ensure that users across devices can see the
>author’s intention. You can always show users an image, but you can’t
>show them a range of characters their system does not support.

This gem is primarily for handling emoji characters in user-generated
content. Depending on your technical stack, these characters could end
up being lost.

## Usage

    Rumoji.encode(str)
    # Takes a String, transforms Emoji into cheat-sheet codes

    Rumoji.encode(str) { |emoji| #your code here }
    # Takes a String, transforms Emoji into whatever you want

    Rumoji.decode(str)
    # Does the reverse of encode

    Rumoji.encode_io(read, write)
    # For an IO pipe (a read stream, and a write stream), transform Emoji from the
    # read end, and write the cheat-sheet codes on the write end.

    Rumoji.decode_io(read, write)
    # Same thing but in reverse!

## Installation

    gem install rumoji

Note that rumoji has only been tested in Rubies >= 1.9!!!

### Some examples:

    puts Rumoji.encode("Lack of cross-device emoji support makes me 😭")
    #=> Lack of cross-device emoji support makes me :sob:

    Rumoji.encode_io(StringIO.new("💩")).string
    #=> ":poop:"

Here's a fun file:

    Rumoji.decode_io($stdin, $stdout)

On the command line

    echo "But Rumoji makes encoding issues a :joy:" | ruby ./funfile.rb
    #=> But Rumoji makes encoding issues a 😂


### Emoji methods

#### .code

The symbol of the emoji surrounded with colons

    Rumoji.encode("😭") {|emoji| emoji.code}
    #=> ":sob:"

#### .symbol

The symbol of the emoji

    Rumoji.encode("😭") {|emoji| emoji.code}
    #=> "sob"

#### .multiple?

Returns true if the emoji is made up of multiple code points. E.g.  🇺🇸

    Rumoji.encode("🇺🇸") {|emoji| emoji.multiple?}
    #=> true

#### .string

The raw emoji

    Rumoji.encode("😭") {|emoji| emoji.string}
    #=> "😭"

Implement the emoji codes from emoji-cheat-sheet.com using a tool like [gemoji](https://github.com/github/gemoji) along with Rumoji, and you'll easily be able to transform user input with raw emoji unicode into images you can show to all users.

_Having trouble discerning what's happening in this README?_ You might be on a device with NO emoji support! All the more reason to use Rumoji. Transcode the raw unicode into something users can understand across devices!

Thanks!

## Copyright
Copyright (c) 2012 - 2016 Mark Wunsch. Licensed under the [MIT License](http://opensource.org/licenses/mit-license.php).
