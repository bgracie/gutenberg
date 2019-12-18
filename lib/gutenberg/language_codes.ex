defmodule Gutenberg.LanguageCodes do
  @iso639_1_codes %{
    "lo" => "Laotian",
    "eo" => "Esperanto",
    "rm" => "Raeto Romance",
    "ja" => "Japanese",
    "om" => "Oromo",
    "cr" => "Cree",
    "ne" => "Nepali",
    "el" => "Greek",
    "fo" => "Faroese",
    "ii" => "Sichuan Yi",
    "za" => "Zhuang",
    "hu" => "Hungarian",
    "oc" => "Occitan",
    "nr" => "South Ndebele",
    "sh" => "Serbo-Croatian",
    "sq" => "Albanian",
    "ug" => "Uyghur",
    "rw" => "Rwandi",
    "cy" => "Welsh",
    "bi" => "Bislama",
    "tn" => "Tswana",
    "ch" => "Chamorro",
    "da" => "Danish",
    "su" => "Sundanese",
    "ss" => "Swati",
    "sv" => "Swedish",
    "ee" => "Ewe",
    "ha" => "Hausa",
    "ay" => "Aymara",
    "ps" => "Pashto",
    "kn" => "Kannada",
    "et" => "Estonian",
    "ta" => "Tamil",
    "ff" => "Peul",
    "nl" => "Dutch",
    "ml" => "Malayalam",
    "vi" => "Vietnamese",
    "ba" => "Bashkir",
    "lv" => "Latvian",
    "id" => "Indonesian",
    "sg" => "Sango",
    "zu" => "Zulu",
    "gu" => "Gujarati",
    "ks" => "Kashmiri",
    "lt" => "Lithuanian",
    "ig" => "Igbo",
    "my" => "Burmese",
    "jv" => "Javanese",
    "br" => "Breton",
    "tl" => "Tagalog",
    "dz" => "Dzongkha",
    "mi" => "Maori",
    "cs" => "Czech",
    "ms" => "Malay",
    "kk" => "Kazakh",
    "te" => "Telugu",
    "fa" => "Persian",
    "kg" => "Kongo",
    "ie" => "Interlingue",
    "bg" => "Bulgarian",
    "qu" => "Quechua",
    "es" => "Spanish",
    "ik" => "Inupiak",
    "ab" => "Abkhazian",
    "en" => "English",
    "cv" => "Chuvash",
    "af" => "Afrikaans",
    "mt" => "Maltese",
    "iu" => "Inuktitut",
    "am" => "Amharic",
    "lg" => "Ganda",
    "ca" => "Catalan",
    "oj" => "Ojibwa",
    "mk" => "Macedonian",
    "tt" => "Tatar",
    "la" => "Latin",
    "ro" => "Romanian",
    "wo" => "Wolof",
    "bm" => "Bambara",
    "sn" => "Shona",
    "co" => "Corsican",
    "ce" => "Chechen",
    "hr" => "Croatian",
    "gl" => "Galician",
    "nn" => "Norwegian Nynorsk",
    "ti" => "Tigrinya",
    "hy" => "Armenian",
    "pi" => "Pali",
    "pa" => "Punjabi",
    "ht" => "Haitian",
    "io" => "Ido",
    "no" => "Norwegian",
    "pt" => "Portuguese",
    "ki" => "Kikuyu",
    "vo" => "Volapük",
    "ln" => "Lingala",
    "ku" => "Kurdish",
    "nd" => "North Ndebele",
    "he" => "Hebrew",
    "fj" => "Fijian",
    "sc" => "Sardinian",
    "yo" => "Yoruba",
    "ga" => "Irish",
    "sr" => "Serbian",
    "hi" => "Hindi",
    "as" => "Assamese",
    "nv" => "Navajo",
    "mn" => "Mongolian",
    "ky" => "Kirghiz",
    "mo" => "Moldovan",
    "ng" => "Ndonga",
    "gv" => "Manx",
    "kw" => "Cornish",
    "ny" => "Chichewa",
    "cu" => "Old Church Slavonic / Old Bulgarian",
    "ko" => "Korean",
    "ho" => "Hiri Motu",
    "ur" => "Urdu",
    "si" => "Sinhalese",
    "so" => "Somalia",
    "kl" => "Greenlandic",
    "km" => "Cambodian",
    "sa" => "Sanskrit",
    "bo" => "Tibetan",
    "sk" => "Slovak",
    "ru" => "Russian",
    "mr" => "Marathi",
    "na" => "Nauruan",
    "kv" => "Komi",
    "sm" => "Samoan",
    "fy" => "West Frisian",
    "eu" => "Basque",
    "ia" => "Interlingua",
    "mg" => "Malagasy",
    "os" => "Ossetian",
    "zh" => "Chinese",
    "kj" => "Kuanyama",
    "av" => "Avar",
    "ts" => "Tsonga",
    "an" => "Aragonese",
    "de" => "German",
    "fi" => "Finnish",
    "it" => "Italian",
    "yi" => "Yiddish",
    "be" => "Belarusian",
    "aa" => "Afar",
    "rn" => "Kirundi",
    "bh" => "Bihari",
    "pl" => "Polish",
    "az" => "Azerbaijani",
    "st" => "Southern Sotho",
    "sw" => "Swahili",
    "gn" => "Guarani",
    "tr" => "Turkish",
    "ak" => "Akan",
    "wa" => "Walloon",
    "ty" => "Tahitian",
    "gd" => "Scottish Gaelic",
    "sd" => "Sindhi",
    "is" => "Icelandic",
    "to" => "Tonga",
    "bn" => "Bengali",
    "mh" => "Marshallese",
    "xh" => "Xhosa",
    "or" => "Oriya",
    "th" => "Thai",
    "li" => "Limburgian",
    "tg" => "Tajik",
    "tk" => "Turkmen",
    "dv" => "Divehi",
    "hz" => "Herero",
    "tw" => "Twi",
    "kr" => "Kanuri",
    "fr" => "French",
    "sl" => "Slovenian",
    "lb" => "Luxembourgish",
    "bs" => "Bosnian",
    "ve" => "Venda",
    "ar" => "Arabic"
  }

  def label(code) do
    @iso639_1_codes[code] || "\"code\""
  end
end
