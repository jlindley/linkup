require 'test/test_helper'

class TestLinkup < Test::Unit::TestCase

  context "tests from daringfireball" do

    should "link plain url" do
      input = 'http://foo.com/blah_blah'
      expected = '<a href="http://foo.com/blah_blah">http://foo.com/blah_blah</a>'
      assert_equal expected, input.linkup
    end

    should "link plain url with trailing slash" do
      input = 'http://foo.com/blah_blah/'
      expected = '<a href="http://foo.com/blah_blah/">http://foo.com/blah_blah/</a>'
      assert_equal expected, input.linkup
    end

    should "not link dot after url with" do
      input = 'http://foo.com/blah_blah.'
      expected = '<a href="http://foo.com/blah_blah">http://foo.com/blah_blah</a>.'
      assert_equal expected, input.linkup
    end

    should "link plain url with trailing slash, but not trailing dot" do
      input = 'http://foo.com/blah_blah/.'
      expected = '<a href="http://foo.com/blah_blah/">http://foo.com/blah_blah/</a>.'
      assert_equal expected, input.linkup
    end

    should "not link link-adjacent parens" do
      input = '(Something like http://foo.com/blah_blah)'
      expected = '(Something like <a href="http://foo.com/blah_blah">http://foo.com/blah_blah</a>)'
      assert_equal expected, input.linkup
    end

    should "link paren-containing link" do
      input = 'http://foo.com/blah_blah_(wikipedia)'
      expected = '<a href="http://foo.com/blah_blah_(wikipedia)">http://foo.com/blah_blah_(wikipedia)</a>'
      assert_equal expected, input.linkup
    end

    should "handle mixed link and non-link parens" do
      input = '(Something like http://foo.com/blah_blah_(wikipedia))'
      expected = '(Something like <a href="http://foo.com/blah_blah_(wikipedia)">http://foo.com/blah_blah_(wikipedia)</a>)'
      assert_equal expected, input.linkup
    end

    should "not link link-adjacent angle brackets" do
      input = '<http://foo.com/blah_blah>'
      expected = '<<a href="http://foo.com/blah_blah">http://foo.com/blah_blah</a>>'
      assert_equal expected, input.linkup
    end

    should "handle link-adjacent angle brackets with trailing slash" do
      input = '<http://foo.com/blah_blah/>'
      expected = '<<a href="http://foo.com/blah_blah/">http://foo.com/blah_blah/</a>>'
      assert_equal expected, input.linkup
    end

    should "not link comma after url" do
      input = 'http://foo.com/blah_blah,'
      expected = '<a href="http://foo.com/blah_blah">http://foo.com/blah_blah</a>,'
      assert_equal expected, input.linkup
    end

    should "not link urls with params" do
      input = 'http://www.example.com/wpstyle/?p=364.'
      expected = '<a href="http://www.example.com/wpstyle/?p=364">http://www.example.com/wpstyle/?p=364</a>.'
      assert_equal expected, input.linkup
    end

    should "link non-protocol specifying, but www-subdomained urls" do
      input = "www.example.com"
      expected = '<a href="http://www.example.com">www.example.com</a>'
      assert_equal expected, input.linkup
    end

    should "link utf-8 IDN domains" do
      input = 'http://✪df.ws/123'
      expected = '<a href="http://✪df.ws/123">http://✪df.ws/123</a>'
      assert_equal expected, input.linkup
    end

    should "link non-standard non-x-prefixed protocols" do
      input = 'rdar://1234'
      expected = '<a href="rdar://1234">rdar://1234</a>'
      assert_equal expected, input.linkup
    end

    should "link not link urls-like strings with only one slash" do
      input = 'rdar:/1234'
      expected = 'rdar:/1234'
      assert_equal expected, input.linkup
    end

    should "link urls with port" do
      input = 'http://example.com:8080'
      expected = '<a href="http://example.com:8080">http://example.com:8080</a>'
      assert_equal expected, input.linkup
    end

    should "link urls with username" do
      input = 'http://userid@example.com'
      expected = '<a href="http://userid@example.com">http://userid@example.com</a>'
      assert_equal expected, input.linkup
    end

    should "link urls with username and password" do
      input = 'http://userid:password@example.com'
      expected = '<a href="http://userid:password@example.com">http://userid:password@example.com</a>'
      assert_equal expected, input.linkup
    end

    should "link urls with username and port" do
      input = 'http://userid@example.com:8080'
      expected = '<a href="http://userid@example.com:8080">http://userid@example.com:8080</a>'
      assert_equal expected, input.linkup
    end

    should "link urls with username and password and port" do
      input = 'http://http://userid:password@example.com:8080'
      expected = '<a href="http://userid:password@example.com:8080">http://userid:password@example.com:8080</a>'
      assert_equal expected, input.linkup
    end

    should "link urls with custom x- prefixed protocols" do
      input = 'x-yojimbo-item://6303E4C1-xxxx-45A6-AB9D-3A908F59AE0E'
      expected = '<a href="x-yojimbo-item://6303E4C1-xxxx-45A6-AB9D-3A908F59AE0E">x-yojimbo-item://6303E4C1-xxxx-45A6-AB9D-3A908F59AE0E</a>'
      assert_equal expected, input.linkup
    end

    should "link mail message urls" do
      input = 'message://%3c330e7f8409726r6a4ba78dkf1fd71420c1bf6ff@mail.gmail.com%3e'
      expected = '<a href="message://%3c330e7f8409726r6a4ba78dkf1fd71420c1bf6ff@mail.gmail.com%3e">message://%3c330e7f8409726r6a4ba78dkf1fd71420c1bf6ff@mail.gmail.com%3e</a>'
      assert_equal expected, input.linkup
    end

    should "link urls with UTF-8 domain and path components" do
      input = "http://➡.ws/䨹"
      expected = '<a href="http://➡.ws/䨹">http://➡.ws/䨹</a>'
      assert_equal expected, input.linkup
    end

    should "link urls with UTF-8 domain and path components, www subdomain, but no protocol" do
      input = "www.➡.ws/䨹"
      expected = '<a href="http://www.➡.ws/䨹">www.➡.ws/䨹</a>'
      assert_equal expected, input.linkup
    end

    should "link urls inside existing xml tags" do
      input = "<tag>http://example.com</tag>"
      expected = '<tag><a href="http://example.com">http://example.com</a></tag>'
      assert_equal expected, input.linkup
    end

  end
  
  context "already-linked urls" do
    should "not re-link urls inside link tags" do
      input = '<a href="http://example.com">http://example.com</tag>'
      expected = '<a href="http://example.com">http://example.com</tag>'
      assert_equal expected, input.linkup
    end
    should "not re-link urls inside link tags with surrounding text" do
      input = '<a href="http://example.com">click http://example.com to go there</tag>'
      expected = '<a href="http://example.com">click http://example.com to go there</tag>'
      assert_equal expected, input.linkup
    end
    should "not re-link urls inside link tags, even with intervening tags" do
      input = '<a href="http://example.com"><i>http://example.com</i></tag>'
      expected = '<a href="http://example.com"><i>http://example.com</i></tag>'
      assert_equal expected, input.linkup
    end
  end
  
end
