# -*- encoding: utf-8 -*-
require "rumoji/version"
require 'stringio'

module Rumoji
  extend self

  def encode(str)
    remapped_codepoints = str.codepoints.flat_map do |codepoint|
      emoji = EMOJI_NAME_TO_CODEPOINT.key codepoint_as_hex(codepoint)
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

  def encode_io(readable, writeable=StringIO.new(""))
    readable.each_codepoint do |codepoint|
      emoji = codepoint_as_hex(codepoint)
      emoji_or_character = EMOJI_NAME_TO_CODEPOINT.has_value?(emoji) ? ":#{EMOJI_NAME_TO_CODEPOINT.key(emoji)}:" : [codepoint].pack("U")
      writeable.write emoji_or_character
    end
    writeable.rewind
    writeable
  end

  def decode_io(readable, writeable=StringIO.new(""))
    readable.each do |word|
      EMOJI_NAME_TO_CODEPOINT.each_pair do |key,value|
        word.gsub!(":#{key}:", [value.to_i(16)].pack("U"))
      end
      writeable.write(word)
    end
    writeable.rewind
    writeable
  end

  def codepoint_as_hex(codepoint)
    codepoint.to_s(16).upcase
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
    # Cats
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
    # Monkeys
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
    thought_balloon:              "1F4AD",

    # NATURE
    sunny:                          "2600",
    umbrella:                       "2614",
    cloud:                          "2601",
    snowflake:                      "2744",
    snowman:                        "26C4",
    zap:                            "26A1",
    cyclone:                        "1F300",
    foggy:                          "1F301",
    ocean:                          "1F30A",
    # Animals
    cat:                            "1F431",
    dog:                            "1F436",
    mouse:                          "1F42D",
    hamster:                        "1F439",
    rabbit:                         "1F430",
    wolf:                           "1F43A",
    frog:                           "1F438",
    tiger:                          "1F42F",
    koala:                          "1F428",
    bear:                           "1F43B",
    pig:                            "1F437",
    pig_nose:                       "1F43D",
    cow:                            "1F42E",
    boar:                           "1F417",
    monkey_face:                    "1F435",
    monkey:                         "1F412",
    horse:                          "1F434",
    racehorse:                      "1F40E",
    camel:                          "1F42B",
    sheep:                          "1F411",
    elephant:                       "1F418",
    panda_face:                     "1F43C",
    snake:                          "1F40D",
    bird:                           "1F426",
    baby_chick:                     "1F424",
    hatched_chick:                  "1F425",
    hatching_chick:                 "1F423",
    chicken:                        "1F414",
    penguin:                        "1F427",
    turtle:                         "1F422",
    bug:                            "1F41B",
    honeybee:                       "1F41D",
    ant:                            "1F41C",
    beetle:                         "1F41E",
    snail:                          "1F40C",
    octopus:                        "1F419",
    tropical_fish:                  "1F420",
    fish:                           "1F41F",
    whale:                          "1F433",
    whale2:                         "1F40B",
    dolphin:                        "1F42C",
    cow2:                           "1F404",
    ram:                            "1F40F",
    rat:                            "1F400",
    water_buffalo:                  "1F403",
    tiger2:                         "1F405",
    rabbit2:                        "1F407",
    dragon:                         "1F409",
    goat:                           "1F410",
    rooster:                        "1F413",
    dog2:                           "1F415",
    pig2:                           "1F416",
    mouse2:                         "1F401",
    ox:                             "1F402",
    dragon_face:                    "1F432",
    blowfish:                       "1F421",
    crocodile:                      "1F40A",
    dromedary_camel:                "1F42A",
    leopard:                        "1F406",
    cat2:                           "1F408",
    poodle:                         "1F429",
    paw_prints:                     "1F43E",
    # Flowers
    bouquet:                        "1F490",
    cherry_blossom:                 "1F338",
    tulip:                          "1F337",
    four_leaf_clover:               "1F340",
    rose:                           "1F339",
    sunflower:                      "1F33B",
    hibiscus:                       "1F33A",
    maple_leaf:                     "1F341",
    leaves:                         "1F343",
    fallen_leaf:                    "1F342",
    herb:                           "1F33F",
    mushroom:                       "1F344",
    cactus:                         "1F335",
    palm_tree:                      "1F334",
    evergreen_tree:                 "1F332",
    deciduous_tree:                 "1F333",
    chestnut:                       "1F330",
    seedling:                       "1F331",
    blossum:                        "1F33C",
    ear_of_rice:                    "1F33E",
    shell:                          "1F41A",
    globe_with_meridians:           "1F310",
    # Moon
    sun_with_face:                  "1F31E",
    full_moon_with_face:            "1F31D",
    new_moon_with_face:             "1F31A",
    new_moon:                       "1F311",
    waxing_crescent_moon:           "1F312",
    first_quarter_moon:             "1F313",
    waxing_gibbous_moon:            "1F314",
    full_moon:                      "1F315",
    waning_gibbous_moon:            "1F316",
    last_quarter_moon:              "1F317",
    waning_crescent_moon:           "1F318",
    last_quarter_moon_with_face:    "1F31C",
    first_quarter_moon_with_face:   "1F31B",
    moon:                           "1F319",
    earth_africa:                   "1F30D",
    earth_americas:                 "1F30E",
    earth_asia:                     "1F30F",
    volcano:                        "1F30B",
    milky_way:                      "1F30C",
    partly_sunny:                   "26C5"

  }

end
