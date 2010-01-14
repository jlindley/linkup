module Linkup

  # for inclusion in String class
  def linkup
    Linkup.linkify(self)
  end

  def self.linkify(string)
    string
  end

end
