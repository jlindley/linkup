#!ruby19
# encoding: utf-8

require 'test/unit'
require 'shoulda'
require 'lib/linkup'

class String
  include Linkup
end
