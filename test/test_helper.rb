require 'test/unit'

require 'rubygems'
require 'shoulda'

require 'lib/linkup'

class String
  include Linkup
end
