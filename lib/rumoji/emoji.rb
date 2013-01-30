# -*- encoding: utf-8 -*-

module Rumoji
  class Emoji
    require 'set'

    attr_reader :name

    def initialize(string, symbols, name = nil)
      @codepoints = string.codepoints
      @cheat_codes = [symbols].flatten
      @name = name || @cheat_codes.first.to_s.upcase.gsub("_", " ")
    end

    def code
      @cheat_codes.first
    end

    def include?(symbol)
      @cheat_codes.include? symbol.to_sym
    end

    def to_s
      @codepoints.to_a.pack("U*")
    end

    def hash
      code.hash
    end

    def hex
      @codepoints.map{|point| point.to_s(16).upcase }.join
    end

    PEOPLE = Set[
      self.new("\u{1F604}", [:smile], "SMILING FACE WITH OPEN MOUTH AND SMILING EYES"),
      self.new("\u{1F606}", [:laughing], "SMILING FACE WITH OPEN MOUTH AND TIGHTLY-CLOSED EYES"),
      self.new("\u{1F60A}", [:blush], "SMILING FACE WITH SMILING EYES"),
      self.new("\u{1F603}", [:smiley], "SMILING FACE WITH OPEN MOUTH"),
      self.new("\u{263A}" , [:relaxed], "WHITE SMILING FACE"),
      self.new("\u{1F60F}", [:smirk], "SMIRKING FACE"),
      self.new("\u{1F60D}", [:heart_eyes], "SMILING FACE WITH HEART-SHAPED EYES"),
      self.new("\u{1F618}", [:kissing_heart], "FACE THROWING KISS"),
      self.new("\u{1F61A}", [:kissing_closed_eyes], "KISSING FACE WITH CLOSED EYES"),
      self.new("\u{1F633}", [:flushed], "FLUSHED FACE"),
      self.new("\u{1F625}", [:relieved], "DISAPPOINTED BUT RELIEVED FACE"),
      self.new("\u{1F60C}", [:satisfied], "RELIEVED FACE"),
      self.new("\u{1F601}", [:grin], "GRINNING FACE WITH SMILING EYES"),
      self.new("\u{1F609}", [:wink], "WINKING FACE"),
      self.new("\u{1F61C}", [:wink2, :stuck_out_tongue_winking_eye], "FACE WITH STUCK OUT TONGUE AND WINKING EYE"), # "kidding, not serious"
      self.new("\u{1F61D}", [:stuck_out_tongue_closed_eyes], "FACE WITH STUCK-OUT TONGUE AND TIGHTLY-CLOSED EYES"), # "kidding, not serious"
      self.new("\u{1F600}", [:grinning], "GRINNING FACE"),
      self.new("\u{1F617}", [:kissing], "KISSING FACE"),
      self.new("\u{1F619}", [:kissing_smiling_eyes], "KISSING FACE WITH SMILING EYES"),
      self.new("\u{1F61B}", [:stuck_out_tongue], "FACE WITH STUCK-OUT TONGUE"),
      self.new("\u{1F634}", [:sleeping], "SLEEPING FACE"),
      self.new("\u{1F61F}", [:worried], "WORRIED FACE"),
      self.new("\u{1F626}", [:frowning], "FROWNING FACE WITH OPEN MOUTH"),
      self.new("\u{1F627}", [:anguished], "ANGUISHED FACE"),
      self.new("\u{1F62E}", [:open_mouth], "FACE WITH OPEN MOUTH"),
      self.new("\u{1F62C}", [:grimacing], "GRIMACING FACE"),
      self.new("\u{1F615}", [:confused], "CONFUSED FACE"),
      self.new("\u{1F62F}", [:hushed], "HUSHED FACE"),
      self.new("\u{1F611}", [:expressionless], "EXPRESSIONLESS FACE"),
      self.new("\u{1F612}", [:unamused], "UNAMUSED FACE"),
      self.new("\u{1F605}", [:sweat_smile], "SMILING FACE WITH OPEN MOUTH AND COLD SWEAT"),
      self.new("\u{1F613}", [:sweat], "FACE WITH COLD SWEAT"),
      self.new("\u{1F629}", [:weary], "WEARY FACE"),
      self.new("\u{1F614}", [:pensive], "PENSIVE FACE"),
      self.new("\u{1F61E}", [:dissapointed], "DISAPPOINTED FACE"),
      self.new("\u{1F616}", [:confounded], "CONFOUNDED FACE"),
      self.new("\u{1F628}", [:fearful], "FEARFUL FACE"),
      self.new("\u{1F630}", [:cold_sweat], "FACE WITH OPEN MOUTH AND COLD SWEAT"),
      self.new("\u{1F623}", [:persevere], "PERSEVERING FACE"),
      self.new("\u{1F622}", [:cry], "CRYING FACE"),
      self.new("\u{1F62D}", [:sob], "LOUDLY CRYING FACE"),
      self.new("\u{1F602}", [:joy], "FACE WITH TEARS OF JOY"),
      self.new("\u{1F632}", [:astonished], "ASTONISHED FACE"),
      self.new("\u{1F631}", [:scream], "FACE SCREAMING IN FEAR"),
      self.new("\u{1F62B}", [:tired_face]),
      self.new("\u{1F620}", [:angry], "ANGRY FACE"),
      self.new("\u{1F621}", [:rage], "POUTING FACE"),
      self.new("\u{1F624}", [:triumph], "FACE WITH LOOK OF TRIUMPH"),
      self.new("\u{1F62A}", [:sleepy], "SLEEPY FACE"),
      self.new("\u{1F60B}", [:yum], "FACE SAVOURING DELICIOUS FOOD"),
      self.new("\u{1F637}", [:mask], "FACE WITH MEDICAL MASK"),
      self.new("\u{1F60E}", [:sunglasses], "SMILING FACE WITH SUNGLASSES"),
      self.new("\u{1F635}", [:dizzy_face]),
      self.new("\u{1F47F}", [:imp]),
      self.new("\u{1F608}", [:smiling_imp], "SMILING FACE WITH HORNS"),
      self.new("\u{1F610}", [:neutral_face]),
      self.new("\u{1F636}", [:no_mouth], "FACE WITHOUT MOUTH"),
      self.new("\u{1F607}", [:innocent], "SMILING FACE WITH HALO"),
      self.new("\u{1F47D}", [:alien], "EXTRATERRESTRIAL ALIEN"),
      self.new("\u{1F49B}", [:yellow_heart]),
      self.new("\u{1F499}", [:blue_heart]),
      self.new("\u{1F49C}", [:purple_heart]),
      self.new("\u{2764}" , [:heart], "HEAVY BLACK HEART"),
      self.new("\u{1F49A}", [:green_heart]),
      self.new("\u{1F494}", [:broken_heart]),
      self.new("\u{1F493}", [:heartbeat], "BEATING HEART"),
      self.new("\u{1F497}", [:heartpulse], "GROWING HEART"),
      self.new("\u{1F495}", [:two_hearts]),
      self.new("\u{1F49E}", [:revolving_hearts]),
      self.new("\u{1F498}", [:cupid], "HEART WITH ARROW"),
      self.new("\u{1F496}", [:sparkling_heart]),
      self.new("\u{2728}" , [:sparkles]),
      self.new("\u{2B50}" , [:star], "WHITE MEDIUM STAR"),
      self.new("\u{1F31F}", [:star2], "GLOWING STAR"),
      self.new("\u{1F4AB}", [:dizzy], "DIZZY SYMBOL"), # "circling stars, squeans"
      self.new("\u{1F4A5}", [:boom, :collision], "COLLISION SYMBOL"),
      self.new("\u{1F4A2}", [:anger], "ANGER SYMBOL"),
      self.new("\u{2757}" , [:exclamation], "HEAVY EXCLAMATION MARK SYMBOL"),
      self.new("\u{2753}" , [:question], "BLACK QUESTION MARK ORNAMENT"),
      self.new("\u{2755}" , [:grey_exclamation], "WHITE EXCLAMATION MARK ORNAMENT"),
      self.new("\u{2754}" , [:grey_question], "WHITE QUESTION MARK ORNAMENT"),
      self.new("\u{1F4A4}", [:zzz], "SLEEPING SYMBOL"),
      self.new("\u{1F4A8}", [:dash], "DASH SYMBOL"), # "running dash, briffits"
      self.new("\u{1F4A6}", [:sweat_drops], "SPLASHING SWEAT SYMBOL"), # "plewds"
      self.new("\u{1F3B6}", [:notes], "MULTIPLE MUSICAL NOTES"), # "dancing notes, mood, melody"
      self.new("\u{1F3B5}", [:musical_note]), # "music, being in good mood"
      self.new("\u{1F525}", [:fire], "FIRE"),
      # Poop
      self.new("\u{1F4A9}", [:hankey, :poop, :shit], "PILE OF POO"), # "dog dirt"
      self.new("\u{1F44D}", [:thumbsup], "THUMBS UP SIGN"),
      self.new("\u{1F44E}", [:thumbsdown], "THUMBS DOWN SIGN"),
      self.new("\u{1F44C}", [:ok_hand], "OK HAND SIGN"),
      self.new("\u{1F44A}", [:punch, :facepunch], "FISTED HAND SIGN"), # "punch
      self.new("\u{270A}" , [:fist], "RAISED FIST"),
      self.new("\u{270C}" , [:v], "VICTORY HAND"),
      self.new("\u{1F44B}", [:wave], "WAVING HAND SIGN"),
      self.new("\u{270B}" , [:hand], "RAISED HAND"),
      self.new("\u{1F450}", [:open_hands], "OPEN HANDS SIGN"),
      self.new("\u{261D}" , [:point_up], "WHITE UP POINTING INDEX"),
      self.new("\u{1F447}", [:point_down], "WHITE DOWN POINTING BACKHAND INDEX"),
      self.new("\u{1F448}", [:point_left], "WHITE LEFT POINTING BACKHAND INDEX"),
      self.new("\u{1F449}", [:point_right], "WHITE RIGHT POINTING BACKHAND INDEX"),
      self.new("\u{1F64C}", [:raised_hands], "PERSON RAISING BOTH HANDS IN CELEBRATION"), # "banzai!"
      self.new("\u{1F64F}", [:pray], "PERSON WITH FOLDED HANDS"), # "can indicate sorrow or regret; can indicate pleading"
      self.new("\u{1F446}", [:point_up_2], "WHITE UP POINTING BACKHAND INDEX"),
      self.new("\u{1F44F}", [:clap], "CLAPPING HANDS SIGN"),
      self.new("\u{1F4AA}", [:muscle], "FLEXED BICEPS"), # "strong, muscled"
      self.new("\u{1F6B6}", [:walking], "PEDESTRIAN"),
      self.new("\u{1F3C3}", [:runner, :running]),
      self.new("\u{1F46B}", [:couple], "MAN AND WOMAN HOLDING HANDS"),
      self.new("\u{1F46A}", [:family]),
      self.new("\u{1F46C}", [:two_men_holding_hands]),
      self.new("\u{1F46D}", [:two_women_holding_hands]),
      self.new("\u{1F483}", [:dancer]),
      self.new("\u{1F46F}", [:dancers], "WOMAN WITH BUNNY EARS"),
      self.new("\u{1F646}", [:ok_woman], "FACE WITH OK GESTURE"),
      self.new("\u{1F645}", [:no_good], "FACE WITH NO GOOD GESTURE"),
      self.new("\u{1F481}", [:information_desk_person]),
      self.new("\u{1F64B}", [:raised_hand], "HAPPY PERSON RAISING ONE HAND"),
      self.new("\u{1F470}", [:bride_with_veil]),
      self.new("\u{1F64E}", [:person_with_pouting_face]),
      self.new("\u{1F64D}", [:person_frowning]),
      self.new("\u{1F647}", [:bow], "PERSON BOWING DEEPLY"),
      self.new("\u{1F48F}", [:couplekiss], "KISS"), # "two people kissing"
      self.new("\u{1F491}", [:couple_with_heart]),
      self.new("\u{1F486}", [:massage], "FACE MASSAGE"),
      self.new("\u{1F487}", [:haircut]), # "usually indicates a beauty parlor"
      self.new("\u{1F485}", [:nail_care], "NAIL POLISH"), # "manicure, nail care"
      self.new("\u{1F466}", [:boy]),
      self.new("\u{1F467}", [:girl]),
      self.new("\u{1F469}", [:woman]),
      self.new("\u{1F468}", [:man]),
      self.new("\u{1F476}", [:baby]),
      self.new("\u{1F475}", [:older_woman]),
      self.new("\u{1F474}", [:older_man]),
      self.new("\u{1F471}", [:person_with_blond_hair]),
      self.new("\u{1F472}", [:man_with_gua_pi_mao]),
      self.new("\u{1F473}", [:man_with_turban]),
      self.new("\u{1F477}", [:construction_worker]),
      self.new("\u{1F46E}", [:cop], "POLICE OFFICER"),
      self.new("\u{1F47C}", [:angel], "BABY ANGEL"),
      self.new("\u{1F478}", [:princess]),
      # Cats
      self.new("\u{1F63A}", [:smiley_cat], "SMILING CAT FACE WITH OPEN MOUTH"),
      self.new("\u{1F638}", [:smile_cat], "GRINNING CAT FACE WITH SMILING EYES"),
      self.new("\u{1F63B}", [:heart_eyes_cat], "SMILING CAT FACE WITH HEART-SHAPED EYES"),
      self.new("\u{1F63D}", [:kissing_cat], "KISSING CAT FACE WITH CLOSED EYES"),
      self.new("\u{1F63C}", [:smirk_cat], "CAT FACE WITH WRY SMILE"),
      self.new("\u{1F640}", [:scream_cat], "WEARY CAT FACE"),
      self.new("\u{1F63F}", [:crying_cat_face], "CRYING CAT FACE"),
      self.new("\u{1F639}", [:joy_cat], "CAT FACE WITH TEARS OF JOY"),
      self.new("\u{1F63E}", [:pouting_cat], "POUTING CAT FACE"),
      self.new("\u{1F479}", [:japanese_ogre]),
      self.new("\u{1F47A}", [:japanese_goblin]),
      # Monkeys
      self.new("\u{1F648}", [:see_no_evil], "SEE-NO-EVIL MONKEY"),
      self.new("\u{1F649}", [:hear_no_evil], "HEAR-NO-EVIL MONKEY"),
      self.new("\u{1F64A}", [:speak_no_evil], "SPEAK-NO-EVIL MONKEY"),
      self.new("\u{1F482}", [:guardsman]),
      self.new("\u{1F480}", [:skull]),
      self.new("\u{1F463}", [:feet], "FOOTPRINTS"),
      self.new("\u{1F444}", [:lips], "MOUTH"),
      self.new("\u{1F48B}", [:kiss], "KISS MARK"), # "lips"
      self.new("\u{1F4A7}", [:droplet]), # "represents a drop of sweat or drop of water"
      self.new("\u{1F442}", [:ear]),
      self.new("\u{1F440}", [:eyes]),
      self.new("\u{1F443}", [:nose]),
      self.new("\u{1F445}", [:tongue]),
      self.new("\u{1F48C}", [:love_letter]),
      self.new("\u{1F464}", [:bust_in_silhouette]), # "guest account"
      self.new("\u{1F465}", [:busts_in_silhouette]), # "accounts"
      self.new("\u{1F4AC}", [:speech_balloon]), # "comic book conversation bubble"
      self.new("\u{1F4AD}", [:thought_balloon]),
    ]

    NATURE = Set[
      self.new("\u{2600}" , [:sunny], "BLACK SUN WITH RAYS"),
      self.new("\u{2614}" , [:umbrella], "UMBRELLA WITH RAIN DROPS"),
      self.new("\u{2601}" , [:cloud]),
      self.new("\u{2744}" , [:snowflake]),
      self.new("\u{26C4}" , [:snowman], "SNOWMAN WITHOUT SNOW"),
      self.new("\u{26A1}" , [:zap], "HIGH VOLTAGE SIGN"),
      self.new("\u{1F300}", [:cyclone]), # "typhoon, hurricane
      self.new("\u{1F301}", [:foggy]),
      self.new("\u{1F30A}", [:ocean], "WATER WAVE"),
      # Animals
      self.new("\u{1F431}", [:cat], "CAT FACE"),
      self.new("\u{1F436}", [:dog], "DOG FACE"),
      self.new("\u{1F42D}", [:mouse], "MOUSE FACE"),
      self.new("\u{1F439}", [:hamster], "HAMSTER FACE"),
      self.new("\u{1F430}", [:rabbit], "RABBIT FACE"),
      self.new("\u{1F43A}", [:wolf], "WOLF FACE"),
      self.new("\u{1F438}", [:frog], "FROG FACE"),
      self.new("\u{1F42F}", [:tiger], "TIGER FACE"),
      self.new("\u{1F428}", [:koala]),
      self.new("\u{1F43B}", [:bear], "BEAR FACE"),
      self.new("\u{1F437}", [:pig], "PIG FACE"),
      self.new("\u{1F43D}", [:pig_nose]),
      self.new("\u{1F42E}", [:cow], "COW FACE"),
      self.new("\u{1F417}", [:boar]),
      self.new("\u{1F435}", [:monkey_face]),
      self.new("\u{1F412}", [:monkey]),
      self.new("\u{1F434}", [:horse], "HORSE FACE"),
      self.new("\u{1F40E}", [:racehorse], "HORSE"),
      self.new("\u{1F42B}", [:camel], "BACTRIAN CAMEL"), # "has two humps"
      self.new("\u{1F411}", [:sheep]),
      self.new("\u{1F418}", [:elephant]),
      self.new("\u{1F43C}", [:panda_face]),
      self.new("\u{1F40D}", [:snake]),
      self.new("\u{1F426}", [:bird]),
      self.new("\u{1F424}", [:baby_chick]),
      self.new("\u{1F425}", [:hatched_chick], "FRONT-FACING BABY CHICK"),
      self.new("\u{1F423}", [:hatching_chick]),
      self.new("\u{1F414}", [:chicken]),
      self.new("\u{1F427}", [:penguin]),
      self.new("\u{1F422}", [:turtle]),
      self.new("\u{1F41B}", [:bug]),
      self.new("\u{1F41D}", [:honeybee]),
      self.new("\u{1F41C}", [:ant]),
      self.new("\u{1F41E}", [:beetle], "LADY BEETLE"), # "ladybird, ladybug, coccinellids"
      self.new("\u{1F40C}", [:snail]),
      self.new("\u{1F419}", [:octopus]),
      self.new("\u{1F420}", [:tropical_fish]),
      self.new("\u{1F41F}", [:fish]),
      self.new("\u{1F433}", [:whale], "SPOUTING WHALE"),
      self.new("\u{1F40B}", [:whale2], "WHALE"),
      self.new("\u{1F42C}", [:dolphin]),
      self.new("\u{1F404}", [:cow2], "COW"),
      self.new("\u{1F40F}", [:ram]),
      self.new("\u{1F400}", [:rat]),
      self.new("\u{1F403}", [:water_buffalo]),
      self.new("\u{1F405}", [:tiger2], "TIGER"),
      self.new("\u{1F407}", [:rabbit2], "RABBIT"),
      self.new("\u{1F409}", [:dragon]),
      self.new("\u{1F410}", [:goat]),
      self.new("\u{1F413}", [:rooster]),
      self.new("\u{1F415}", [:dog2], "DOG"),
      self.new("\u{1F416}", [:pig2], "PIG"),
      self.new("\u{1F401}", [:mouse2], "MOUSE"),
      self.new("\u{1F402}", [:ox]),
      self.new("\u{1F432}", [:dragon_face]),
      self.new("\u{1F421}", [:blowfish]),
      self.new("\u{1F40A}", [:crocodile]),
      self.new("\u{1F42A}", [:dromedary_camel]), # "has a single hump"
      self.new("\u{1F406}", [:leopard]),
      self.new("\u{1F408}", [:cat2], "CAT"),
      self.new("\u{1F429}", [:poodle]),
      self.new("\u{1F43E}", [:paw_prints]),
      # Flowers
      self.new("\u{1F490}", [:bouquet]),
      self.new("\u{1F338}", [:cherry_blossom]),
      self.new("\u{1F337}", [:tulip]),
      self.new("\u{1F340}", [:four_leaf_clover]),
      self.new("\u{1F339}", [:rose]),
      self.new("\u{1F33B}", [:sunflower]),
      self.new("\u{1F33A}", [:hibiscus]),
      self.new("\u{1F341}", [:maple_leaf]),
      self.new("\u{1F343}", [:leaves], "LEAF FLUTTERING IN WIND"),
      self.new("\u{1F342}", [:fallen_leaf]),
      self.new("\u{1F33F}", [:herb]),
      self.new("\u{1F344}", [:mushroom]),
      self.new("\u{1F335}", [:cactus]),
      self.new("\u{1F334}", [:palm_tree]),
      self.new("\u{1F332}", [:evergreen_tree]),
      self.new("\u{1F333}", [:deciduous_tree]),
      self.new("\u{1F330}", [:chestnut]),
      self.new("\u{1F331}", [:seedling]),
      self.new("\u{1F33C}", [:blossum]), # "daisy"
      self.new("\u{1F33E}", [:ear_of_rice]),
      self.new("\u{1F41A}", [:shell], "SPIRAL SHELL"),
      self.new("\u{1F310}", [:globe_with_meridians]), # "used to indicate international input source, world clocks with time zones, etc."
      # Moon
      self.new("\u{1F31E}", [:sun_with_face]),
      self.new("\u{1F31D}", [:full_moon_with_face]),
      self.new("\u{1F31A}", [:new_moon_with_face]),
      self.new("\u{1F311}", [:new_moon], "NEW MOON SYMBOL"),
      self.new("\u{1F312}", [:waxing_crescent_moon], "WAXING CRESCENT MOON SYMBOL"),
      self.new("\u{1F313}", [:first_quarter_moon], "FIRST QUARTER MOON SYMBOL"), # "half moon"
      self.new("\u{1F314}", [:waxing_gibbous_moon], "WAXING GIBBOUS MOON SYMBOL"), # "waxing moon"
      self.new("\u{1F315}", [:full_moon], "FULL MOON SYMBOL"),
      self.new("\u{1F316}", [:waning_gibbous_moon], "WAINING GIBBOUS MOON SYMBOL"),
      self.new("\u{1F317}", [:last_quarter_moon], "LAST QUARTER MOON SYMBOL"),
      self.new("\u{1F318}", [:waning_crescent_moon], "WANING CRESCENT MOON SYMBOL"),
      self.new("\u{1F31C}", [:last_quarter_moon_with_face]),
      self.new("\u{1F31B}", [:first_quarter_moon_with_face]),
      self.new("\u{1F319}", [:moon], "CRESCENT MOON"), # "may indicate either the first or last quarter moon"
      self.new("\u{1F30D}", [:earth_africa], "EARTH GLOBE EUROPE-AFRICA"),
      self.new("\u{1F30E}", [:earth_americas], "EARTH GLOBE AMERICAS"),
      self.new("\u{1F30F}", [:earth_asia], "EARTH GLOBE ASIA-AUSTRALIA"),
      self.new("\u{1F30B}", [:volcano]),
      self.new("\u{1F30C}", [:milky_way]),
      self.new("\u{26C5}" , [:partly_sunny], "SUN BEHIND CLOUD")
    ]

    OBJECTS = Set[
      self.new("\u{1F38D}", [:bamboo], "PINE DECORATION"), # "Japanese new year's door decoration
      self.new("\u{1F49D}", [:gift_heart], "HEART WITH RIBBON"),
      self.new("\u{1F38E}", [:dolls], "JAPANESE DOLLS"), # "Japanese Hinamatsuri or girls' doll festival"
      self.new("\u{1F49D}", [:gift_heart], "HEART WITH RIBBON"),
      self.new("\u{1F392}", [:school_satchel]), # "Japanese school entrance ceremony"
      self.new("\u{1F393}", [:mortar_board], "GRADUATION CAP"), # "graduation ceremony"
      self.new("\u{1F38F}", [:flags], "CARP STREAMER"),
      self.new("\u{1F386}", [:fireworks]),
      self.new("\u{1F387}", [:sparkler], "FIREWORK SPARKLER"),
      self.new("\u{1F390}", [:wind_chime]),
      self.new("\u{1F391}", [:rice_scene], "MOON VIEWING CEREMONY"), # "Japanese Otsukimi harvest celebration"
      self.new("\u{1F383}", [:jack_o_lantern], "JACK-O-LANTERN"), # "Hallowe'en"
      self.new("\u{1F47B}", [:ghost]),
      self.new("\u{1F385}", [:santa], "FATHER CHRISTMAS"), # "Santa Claus"
    ]

    ALL = PEOPLE | NATURE | OBJECTS

    def self.find(symbol)
      ALL.find {|emoji| emoji.include? symbol }
    end

    def self.find_by_string(string)
      ALL.find {|emoji| emoji.to_s == string }
    end

    def self.find_by_codepoint(codepoint)
      ALL.find {|emoji| emoji.hex == codepoint.to_s(16).upcase }
    end
  end
end
