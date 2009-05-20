
require 'test/unit'
require 'dns_guru'

class TestDnsGuru < Test::Unit::TestCase
	
	def setup
		DnsGuru.init(File.join(File.dirname(__FILE__), "config.rb"))
	end

	def test_match
		assert_equal({:app => 'www', :stage => 'development', :brand => 'google', :tld => 'com'}, DnsGuru.match("www.google.com"))
	end

end
