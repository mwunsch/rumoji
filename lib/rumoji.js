// coding: utf-8
var fs   = require('fs');
var readline = require('readline');

var punycode = require('punycode');
var yaml = require('js-yaml');
var _ = require('lodash');

var nature = yaml.safeLoad(fs.readFileSync('rumoji/nature.yml', 'utf-8'));
var objects = yaml.safeLoad(fs.readFileSync('rumoji/objects.yml', 'utf-8'));
var people = yaml.safeLoad(fs.readFileSync('rumoji/people.yml', 'utf-8'));
var places = yaml.safeLoad(fs.readFileSync('rumoji/places.yml', 'utf-8'));
var symbols = yaml.safeLoad(fs.readFileSync('rumoji/symbols.yml', 'utf-8'));
var keysMap = _.merge({}, nature, objects, people, places, symbols);
var valuesMap = _.invert(keysMap);

// Transform emoji into its cheat-sheet code
var encode = function(str) {
  return str.replace(/:([^s:]?[\w-]+):/, function(m, p){ return keysMap[p] });
}

fixedFromCharCode = function (code) {
  /*jshint bitwise: false*/
  if (code > 0xffff) {
    code -= 0x10000;

    var surrogate1 = 0xd800 + (code >> 10)
    , surrogate2 = 0xdc00 + (code & 0x3ff);

    return String.fromCharCode(surrogate1, surrogate2);
  } else {
    return String.fromCharCode(code);
  }
};

// Transform a cheat-sheet code into an Emoji
var decode = function(str) {
  res = []
  str = punycode.ucs2.decode(str);
  _(str).forEach(function(n) {
    c = fixedFromCharCode(n);
    key = valuesMap[c]
    if (key) {
      res.push(':');
      res.push(key);
      res.push(':');
    } else {
      res.push(c);
    }
  }).value();
  return res.join('');
}

module.exports.VERSION   = '1.0.0';
module.exports.NATURE    = nature;
module.exports.OBJECTS   = objects;
module.exports.PEOPLE    = people;
module.exports.PLACES    = places;
module.exports.SYMBOLS   = symbols;
module.exports.ALL       = keysMap;
module.exports.encode    = encode;
module.exports.decode    = decode;
