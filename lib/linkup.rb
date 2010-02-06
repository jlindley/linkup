#!ruby19
# encoding: utf-8
module Linkup

  # for inclusion in String class
  def linkup
    Linkup.linkify(self)
  end

  def self.linkify(string)
    Linker.new(string).to_s
  end

  class Linker

    attr_accessor :original

    LINK_REGEX =  /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s<]|\/)))/u

    def initialize(string)
      self.original = string
    end

    def already_linked?
      original.match(/href=/)
    end

    def linkify_text(text)
      text.gsub(LINK_REGEX) do |match|
        prefix = if (match =~/\Awww\./)
          prefix = 'http://'
        end
        %Q[<a href="#{prefix}#{match}">#{match}</a>]
      end
    end

    def to_s
      already_linked? ? original : linkify_text(original)
    end

  end

end
