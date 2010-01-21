linkup
===

A Ruby Gem. It will add link tags to url-like string embedded in text, without re-linking existing links.

Caveat: If the text contains already linked urls, then the original string will be returned. It's not smart about telling which urls are already linked or not linked, and so just returns the original string if it sees any href='s in the passed string.

Background
---

Based on this regex by John Gruber: http://daringfireball.net/2009/11/liberal_regex_for_matching_urls

Provide hyperlinks for plain text urls.

From the link:

"It makes no attempt to parse URLs according to any official specification. It isn’t limited to predefined URL protocols. It should be clever about things like parentheses and trailing punctuation."

Usage
---

The sane, non-object-space-polluting way:

    Linkup.linkify("string with url http://example.com")

Or, include it in the string class To add a method called 'linkup' to every string object:

    class String; include Linkup; end
    
    "string with url http://example.com".linkup

Installation
---

gem install linkup

