// to prevent variable collisions when working with unknown js code/html
export const NO_COLLISION_UNIQUE_ATTR = 'rnh290318';
export const ON_ICON: string = "assets/icon-on-128.png";
export const OFF_ICON: string = "assets/icon-off-128.png";
export const ORDINAL_CMD_DELAY = 500;

export const CONFIDENCE_THRESHOLD = 0.0;
export const ORDINALS_TO_DIGITS = {
    "first": 1,
    "1st": 1,
    "i": 1,
    "second": 2,
    "2nd": 2,
    "ii": 2,
    "third": 3,
    "3rd": 3,
    "iii": 3,
    "fourth": 4,
    "forth": 4,
    "4th": 4,
    "iv": 4,
    "fifth": 5,
    "fit": 5,
    "5th": 5,
    "v": 5,
    "sixth": 6,
    "6th": 6,
    "vi": 6,
    "seventh": 7,
    "7th": 7,
    "vii": 7,
    "eigth": 8,
    "8th": 8,
    "viii": 8,
    "ninth": 9,
    "9th": 9,
    "ix": 9,
    "tenth": 10,
    "10th": 10,
    "x": 10,
    "eleventh": 11,
    "11th": 11,
    "xi": 11,
    "twelfe": 12,
    "twelve": 12,
    "12th": 12,
    "xii": 12,
    "thirteenth": 13,
    "13th": 13,
    "xiii": 13,
    "fourteenth": 14,
    "14th": 14,
    "fourteen": 14,
    "xiv": 14,
    "fifteenth": 15,
    "15th": 15,
    "xv": 15,
    "sixteenth": 16,
    "16th": 16,
    "xvi": 16,
    "seventeenth": 17,
    "17th": 17,
    "xvii": 17,
    "eighteenth": 18,
    "18th": 18,
    "xviii": 18,
    "nineteenth": 19,
    "19th": 19,
    "xix": 19,
    "twentieth": 20,
    "20th": 20,
    "xx": 20,
    "twenty-first": 21,
    "21st": 21,
    "xxi": 21,
    "twenty-second": 22,
    "22nd": 22,
    "xxii": 22,
    "twenty-third": 23,
    "23rd": 23,
    "xxiii": 23,
    "twenty-fourth": 24,
    "24th": 24,
    "xxiv": 24,
    "twenty-fifth": 25,
    "25th": 25,
    "xxv": 25,
    "twenty-sixth": 26,
    "26th": 26,
    "xxvi": 26,
    "twenty-seventh": 27,
    "27th": 27,
    "xxvii": 27,
    "twenty-eighth": 28,
    "28th": 28,
    "xxviii": 28,
    "twenty-ninth": 29,
    "29th": 29,
    "xxix": 29,
    "thirtieth": 30,
    "30th": 30,
    "xxx": 30,
    "thirty-first": 31,
    "31st": 31,
    "xxxi": 31,
    "thirty-second": 32,
    "32nd": 32,
    "xxxii": 32,
    "thirty-third": 33,
    "33rd": 33,
    "xxxiii": 33,
    "thirty-fourth": 34,
    "34th": 34,
    "xxxiv": 34,
    "thirty-fifth": 35,
    "35th": 35,
    "xxxv": 35,
    "thirty-sixth": 36,
    "36th": 36,
    "xxxvi": 36,
    "thirty-seventh": 37,
    "37th": 37,
    "xxxvii": 37,
    "thirty-eighth": 38,
    "38th": 38,
    "xxxviii": 38,
    "thirty-ninth": 39,
    "39th": 39,
    "xxxix": 39,
    "fortieth": 40,
    "40th": 40,
    "xl": 40,
    "forty-first": 41,
    "41st": 41,
    "xli": 41,
    "forty-second": 42,
    "42nd": 42,
    "xlii": 42,
    "forty-third": 43,
    "43rd": 43,
    "xliii": 43,
    "forty-fourth": 44,
    "44th": 44,
    "xliv": 44,
    "forty-fifth": 45,
    "45th": 45,
    "xlv": 45,
    "forty-sixth": 46,
    "46th": 46,
    "xlvi": 46,
    "forty-seventh": 47,
    "47th": 47,
    "xlvii": 47,
    "forty-eighth": 48,
    "48th": 48,
    "xlviii": 48,
    "forty-ninth": 49,
    "49th": 49,
    "xlix": 49,
    "fiftieth": 50,
    "50th": 50,
    "l": 50,
    "fifty-first": 51,
    "51st": 51,
    "li": 51,
    "fifty-second": 52,
    "52nd": 52,
    "lii": 52,
    "fifty-third": 53,
    "53rd": 53,
    "liii": 53,
    "fifty-fourth": 54,
    "54th": 54,
    "liv": 54,
    "fifty-fifth": 55,
    "55th": 55,
    "lv": 55,
    "fifty-sixth": 56,
    "56th": 56,
    "lvi": 56,
    "fifty-seventh": 57,
    "57th": 57,
    "lvii": 57,
    "fifty-eighth": 58,
    "58th": 58,
    "lviii": 58,
    "fifty-ninth": 59,
    "59th": 59,
    "lix": 59,
    "sixtieth": 60,
    "60th": 60,
    "lx": 60,
    "sixty-first": 61,
    "61st": 61,
    "lxi": 61,
    "sixty-second": 62,
    "62nd": 62,
    "lxii": 62,
    "sixty-third": 63,
    "63rd": 63,
    "lxiii": 63,
    "sixty-fourth": 64,
    "64th": 64,
    "lxiv": 64,
    "sixty-fifth": 65,
    "65th": 65,
    "lxv": 65,
    "sixty-sixth": 66,
    "66th": 66,
    "lxvi": 66,
    "sixty-seventh": 67,
    "67th": 67,
    "lxvii": 67,
    "sixty-eighth": 68,
    "68th": 68,
    "lxviii": 68,
    "sixty-ninth": 69,
    "69th": 69,
    "lxix": 69,
    "seventieth": 70,
    "70th": 70,
    "lxx": 70,
    "seventy-first": 71,
    "71st": 71,
    "lxxi": 71,
    "seventy-second": 72,
    "72nd": 72,
    "lxxii": 72,
    "seventy-third": 73,
    "73rd": 73,
    "lxxiii": 73,
    "seventy-fourth": 74,
    "74th": 74,
    "lxxiv": 74,
    "seventy-fifth": 75,
    "75th": 75,
    "lxxv": 75,
    "seventy-sixth": 76,
    "76th": 76,
    "lxxvi": 76,
    "seventy-seventh": 77,
    "77th": 77,
    "lxxvii": 77,
    "seventy-eighth": 78,
    "78th": 78,
    "lxxviii": 78,
    "seventy-ninth": 79,
    "79th": 79,
    "lxxix": 79,
    "eightieth": 80,
    "80th": 80,
    "lxxx": 80,
    "eighty-first": 81,
    "81st": 81,
    "lxxxi": 81,
    "eighty-second": 82,
    "82nd": 82,
    "lxxxii": 82,
    "eighty-third": 83,
    "83rd": 83,
    "lxxxiii": 83,
    "eighty-fourth": 84,
    "84th": 84,
    "lxxxiv": 84,
    "eighty-fifth": 85,
    "85th": 85,
    "lxxxv": 85,
    "eighty-sixth": 86,
    "86th": 86,
    "lxxxvi": 86,
    "eighty-seventh": 87,
    "87th": 87,
    "lxxxvii": 87,
    "eighty-eighth": 88,
    "88th": 88,
    "lxxxviii": 88,
    "eighty-ninth": 89,
    "89th": 89,
    "lxxxix": 89,
    "ninetieth": 90,
    "90th": 90,
    "xc": 90,
    "ninety-first": 91,
    "91st": 91,
    "xci": 91,
    "ninety-second": 92,
    "92nd": 92,
    "xcii": 92,
    "ninety-third": 93,
    "93rd": 93,
    "xciii": 93,
    "ninety-fourth": 94,
    "94th": 94,
    "xciv": 94,
    "ninety-fifth": 95,
    "95th": 95,
    "xcv": 95,
    "ninety-sixth": 96,
    "96th": 96,
    "xcvi": 96,
    "ninety-seventh": 97,
    "97th": 97,
    "xcvii": 97,
    "ninety-eighth": 98,
    "98th": 98,
    "xcviii": 98,
    "ninety-ninth": 99,
    "99th": 99,
    "xcix": 99,
    "one hundredth": 100,
    "100th": 100,
};
export const NUMBERS_TO_DIGITS = {
    "1": 1,
    "one": 1,
    "2": 2,
    "two": 2,
    "3": 3,
    "three": 3,
    "4": 4,
    "four": 4,
    "5": 5,
    "five": 5,
    "6": 6,
    "six": 6,
    "7": 7,
    "seven": 7,
    "8": 8,
    "eight": 8,
    "9": 9,
    "nine": 9,
    "10": 10,
    "ten": 10,
    "11": 11,
    "eleven": 11,
    "12": 12,
    "twelve": 12,
    "13": 13,
    "thirteen": 13,
    "14": 14,
    "fourteen": 14,
    "15": 15,
    "fifteen": 15,
    "16": 16,
    "sixteen": 16,
    "17": 17,
    "seventeen": 17,
    "18": 18,
    "eighteen": 18,
    "19": 19,
    "nineteen": 19,
    "20": 20,
    "twenty": 20,
    "21": 21,
    "twenty-one": 21,
    "22": 22,
    "twenty-two": 22,
    "23": 23,
    "twenty-three": 23,
    "24": 24,
    "twenty-four": 24,
    "25": 25,
    "twenty-five": 25,
    "26": 26,
    "twenty-six": 26,
    "27": 27,
    "twenty-seven": 27,
    "28": 28,
    "twenty-eight": 28,
    "29": 29,
    "twenty-nine": 29,
    "30": 30,
    "thirty": 30,
    "31": 31,
    "thirty-one": 31,
    "32": 32,
    "thirty-two": 32,
    "33": 33,
    "thirty-three": 33,
    "34": 34,
    "thirty-four": 34,
    "35": 35,
    "thirty-five": 35,
    "36": 36,
    "thirty-six": 36,
    "37": 37,
    "thirty-seven": 37,
    "38": 38,
    "thirty-eight": 38,
    "39": 39,
    "thirty-nine": 39,
    "40": 40,
    "forty": 40,
    "41": 41,
    "forty-one": 41,
    "42": 42,
    "forty-two": 42,
    "43": 43,
    "forty-three": 43,
    "44": 44,
    "forty-four": 44,
    "45": 45,
    "forty-five": 45,
    "46": 46,
    "forty-six": 46,
    "47": 47,
    "forty-seven": 47,
    "48": 48,
    "forty-eight": 48,
    "49": 49,
    "forty-nine": 49,
    "50": 50,
    "fifty": 50,
    "51": 51,
    "fifty-one": 51,
    "52": 52,
    "fifty-two": 52,
    "53": 53,
    "fifty-three": 53,
    "54": 54,
    "fifty-four": 54,
    "55": 55,
    "fifty-five": 55,
    "56": 56,
    "fifty-six": 56,
    "57": 57,
    "fifty-seven": 57,
    "58": 58,
    "fifty-eight": 58,
    "59": 59,
    "fifty-nine": 59,
    "60": 60,
    "sixty": 60,
    "61": 61,
    "sixty-one": 61,
    "62": 62,
    "sixty-two": 62,
    "63": 63,
    "sixty-three": 63,
    "64": 64,
    "sixty-four": 64,
    "65": 65,
    "sixty-five": 65,
    "66": 66,
    "sixty-six": 66,
    "67": 67,
    "sixty-seven": 67,
    "68": 68,
    "sixty-eight": 68,
    "69": 69,
    "sixty-nine": 69,
    "70": 70,
    "seventy": 70,
    "71": 71,
    "seventy-one": 71,
    "72": 72,
    "seventy-two": 72,
    "73": 73,
    "seventy-three": 73,
    "74": 74,
    "seventy-four": 74,
    "75": 75,
    "seventy-five": 75,
    "76": 76,
    "seventy-six": 76,
    "77": 77,
    "seventy-seven": 77,
    "78": 78,
    "seventy-eight": 78,
    "79": 79,
    "seventy-nine": 79,
    "80": 80,
    "eighty": 80,
    "81": 81,
    "eighty-one": 81,
    "82": 82,
    "eighty-two": 82,
    "83": 83,
    "eighty-three": 83,
    "84": 84,
    "eighty-four": 84,
    "85": 85,
    "eighty-five": 85,
    "86": 86,
    "eighty-six": 86,
    "87": 87,
    "eighty-seven": 87,
    "88": 88,
    "eighty-eight": 88,
    "89": 89,
    "eighty-nine": 89,
    "90": 90,
    "ninety": 90,
    "91": 91,
    "ninety-one": 91,
    "92": 92,
    "ninety-two": 92,
    "93": 93,
    "ninety-three": 93,
    "94": 94,
    "ninety-four": 94,
    "95": 95,
    "ninety-five": 95,
    "96": 96,
    "ninety-six": 96,
    "97": 97,
    "ninety-seven": 97,
    "98": 98,
    "ninety-eight": 98,
    "99": 99,
    "ninety-nine": 99,
    "100": 100,
    "one-hundred": 100,
    "hundred": 100,
    "one hundred": 100,
};

// less common -> common
// global homophones that all plugins share
// mis-hearings kept in homophones so they can be easily tracked for removal
// as voice recognition improves
export const HOMOPHONES = {
    "for": "four",
    'stirred': 'third',
    'aladdin': 'eleven',
    "letter": "eleven",
    "to": "two",
    "0": "o",
    "too": "two",
    "sex": "six",
    '\\.': ' dot ',
    ',': ' comma ',
    'i\'m': 'i am',
};
