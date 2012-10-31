# Rumoji

This is a tool to convert Emoji UTF-8 into the codes used by http://www.emoji-cheat-sheet.com/ and back again.

Why would you want to do this? Read this _forthcoming_ blog post: ...

## tl;dr

>**Do not store emoji unicodes in your database. Store the human-friendly code and support the emoji-cheat-sheet.**

>By doing this, you can ensure that users across devices can see the author’s intention. You can always show users an image, but you can’t show them a range of characters their system does not support.


## Usage

    Rumoji.encode(str)
    # Takes a String, transforms Emoji into cheat-sheet codes

    Rumoji.decode(str)
    # Does the reverse

Thanks!

## Copyright
Copyright (c) 2009 - 2012 Mark Wunsch. Licensed under the MIT License.

