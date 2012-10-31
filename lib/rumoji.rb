# -*- encoding: utf-8 -*-
require "rumoji/version"
require 'stringio'

module Rumoji
  extend self

  def encode(str)
    remapped_codepoints = str.codepoints.flat_map do |codepoint|
      emoji = EMOJI_NAME_TO_CODEPOINT.key(codepoint.to_s(16).upcase)
      emoji ? ":#{emoji}:".codepoints.entries : codepoint
    end
    remapped_codepoints.pack("U*")
  end

  def decode(str)
    duplicate = str.dup
    EMOJI_NAME_TO_CODEPOINT.each_pair do |key, value|
      duplicate.gsub! ":#{key}:", [value.to_i(16)].pack("U")
    end
    duplicate
  end

  def encode_io(input, output=StringIO.new(""))
    input.each_codepoint do |codepoint|
      emoji = codepoint.to_s(16).upcase
      emoji_or_character = EMOJI_NAME_TO_CODEPOINT.has_value?(emoji) ? ":#{EMOJI_NAME_TO_CODEPOINT.key(emoji)}:" : [codepoint].pack("U")
      output.write emoji_or_character
    end
    output.rewind
    output
  end

  def decode_io(input, output=StringIO.new(""))
    input.each do |word|
      EMOJI_NAME_TO_CODEPOINT.each_pair do |key,value|
        word.gsub!(":#{key}:", [value.to_i(16)].pack("U"))
      end
      output.write(word)
    end
    output.rewind
    output
  end

  EMOJI_NAME_TO_CODEPOINT = {
    # PEOPLE
    smile:                        "1F604",
    laughing:                     "1F606",
    blush:                        "1F60A",
    smiley:                       "1F603",
    relaxed:                      "263A",
    smirk:                        "1F60F",
    heart_eyes:                   "1F60D",
    kissing_heart:                "1F618",
    kissing_closed_eyes:          "1F61A",
    flushed:                      "1F633",
    relieved:                     "1F625",
    satisfied:                    "1F60C",
    grin:                         "1F601",
    wink:                         "1F609",
    wink2:                        "1F61C",
    stuck_out_tongue_winking_eye: "1F61C",
    stuck_out_tongue_closed_eyes: "1F61D",
    grinning:                     "1F600",
    kissing:                      "1F617",
    kissing_smiling_eyes:         "1F619",
    stuck_out_tongue:             "1F61B",
    sleeping:                     "1F634",
    worried:                      "1F61F",
    frowning:                     "1F626",
    anguished:                    "1F627",
    open_mouth:                   "1F62E",
    grimacing:                    "1F62C",
    confused:                     "1F615",
    hushed:                       "1F62F",
    expressionless:               "1F611",
    unamused:                     "1F612",
    sweat_smile:                  "1F605",
    sweat:                        "1F613",
    weary:                        "1F629",
    pensive:                      "1F614",
    dissapointed:                 "1F61E",
    confounded:                   "1F616",
    fearful:                      "1F628",
    cold_sweat:                   "1F630",
    persevere:                    "1F623",
    cry:                          "1F622",
    sob:                          "1F62D",
    joy:                          "1F602",
    astonished:                   "1F632",
    scream:                       "1F631",
    tired_face:                   "1F62B",
    angry:                        "1F620",
    rage:                         "1F621",
    triumph:                      "1F624",
    sleepy:                       "1F62A",
    yum:                          "1F60B",
    mask:                         "1F637",
    sunglasses:                   "1F60E",
    dizzy_face:                   "1F635",
    imp:                          "1F47F",
    smiling_imp:                  "1F608",
    neutral_face:                 "1F610",
    no_mouth:                     "1F636",
    innocent:                     "1F607",

    alien:                        "1F47D",

    yellow_heart:                 "1F49B",
    blue_heart:                   "1F499",
    purple_heart:                 "1F49C",
    heart:                        "2764",
    green_heart:                  "1F49A",
    broken_heart:                 "1F494",
    heartbeat:                    "1F493",
    heartpulse:                   "1F497",
    two_hearts:                   "1F495",
    revolving_hearts:             "1F49E",
    cupid:                        "1F498",
    sparkling_heart:              "1F496",

    sparkles:                     "2728",
    star:                         "2B50", # In "Nature" range
    star2:                        "1F31F",
    dizzy:                        "1F4AB",
    boom:                         "1F4A5",
    collision:                    "1F4A5",
    anger:                        "1F4A2",

    # In "Symbols" range
    exclamation:                  "2757",
    question:                     "2753",
    grey_exclamation:             "2755",
    grey_question:                "2754",

    zzz:                          "1F4A4",
    dash:                         "1F4A8",
    sweat_drops:                  "1F4A6",

    # In "Objects" range
    notes:                        "1F3B6",
    musical_note:                 "1F3B5",

    fire:                         "1F525",

    # So much poop
    hankey:                       "1F4A9",
    poop:                         "1F4A9",
    shit:                         "1F4A9",

    thumbsup:                     "1F44D",
    thumbsdown:                   "1F44E",
    ok_hand:                      "1F44C",
    punch:                        "1F44A",
    facepunch:                    "1F44A",
    fist:                         "270A",
    v:                            "270C",
    wave:                         "1F44B",
    hand:                         "270B",

    open_hands:                   "1F450",
    point_up:                     "261D",
    point_down:                   "1F447",
    point_left:                   "1F448",
    point_right:                  "1F449",
    raised_hands:                 "1F64C",
    pray:                         "1F64F",
    point_up_2:                   "1F446",
    clap:                         "1F44F",
    muscle:                       "1F4AA",

    walking:                      "1F6B6",
    runner:                       "1F3C3",
    running:                      "1F3C3",
    couple:                       "1F46B",
    family:                       "1F46A",
    two_men_holding_hands:        "1F46C",
    two_women_holding_hands:      "1F46C",
    dancer:                       "1F483",
    dancers:                      "1F46F",
    ok_woman:                     "1F646",
    no_good:                      "1F645",
    information_desk_person:      "1F481",
    raised_hand:                  "1F64B",
    bride_with_veil:              "1F470",
    person_with_pouting_face:     "1F64E",
    person_frowning:              "1F64D",
    bow:                          "1F647",
    couplekiss:                   "1F48F",
    couple_with_heart:            "1F491",
    massage:                      "1F486",
    haircut:                      "1F487",
    nail_care:                    "1F485",
    boy:                          "1F466",
    girl:                         "1F467",
    woman:                        "1F469",
    man:                          "1F468",
    baby:                         "1F476",
    older_woman:                  "1F475",
    older_man:                    "1F474",
    person_with_blond_hair:       "1F471",
    man_with_gua_pi_mao:          "1F472",
    man_with_turban:              "1F473",
    construction_worker:          "1F477",
    cop:                          "1F46E",
    angel:                        "1F47C",
    princess:                     "1F478",

    smiley_cat:                   "1F63A",
    smile_cat:                    "1F638",
    heart_eyes_cat:               "1F63B",
    kissing_cat:                  "1F63D",
    smirk_cat:                    "1F63C",
    scream_cat:                   "1F640",
    crying_cat_face:              "1F63F",
    joy_cat:                      "1F639",
    pouting_cat:                  "1F63E",

    japanese_ogre:                "1F479",
    japanese_goblin:              "1F47A",

    see_no_evil:                  "1F648",
    hear_no_evil:                 "1F649",
    speak_no_evil:                "1F649",

    guardsman:                    "1F482",
    skull:                        "1F480",

    feet:                         "1F463",
    lips:                         "1F444",
    kiss:                         "1F48B",
    droplet:                      "1F4A7",
    ear:                          "1F442",
    eyes:                         "1F440",
    nose:                         "1F443",
    tongue:                       "1F445",
    love_letter:                  "1F48C",
    bust_in_silhouette:           "1F464",
    busts_in_silhouette:          "1F465",
    speech_balloon:               "1F4AC",
    thought_balloon:              "1F4AD"
  }

end
