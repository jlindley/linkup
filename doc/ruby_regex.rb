#!/usr/bin/env ruby

r = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/

s1 = "Blah blah http://blah.com blah http://foo.com/alsdkjf.html"
s2 = "blah blah blah blah"

m1 = s1.scan(r)
puts m1.map{|m| m[0] }.join(" ")

m2 = s2.scan(r)

puts m2.map{|m| m[0] }.join(" ")

s1_linked = s1.gsub(r) do |url|
  %Q[<a href="#{url}">#{url}</a>]
end

puts s1_linked
