
require 'test/unit'
require 'dns_guru'

class TestDnsGuru < Test::Unit::TestCase
	
	def setup
		DnsGuru.init(File.join(File.dirname(__FILE__), "config.rb"))
	end

	def test_match
		assert_equal({:app => 'www', :stage => 'production', :brand => 'google', :tld => 'com'}, DnsGuru.match("www.google.com"))
	end

	def test_generate
		assert_equal("www.google.com",  DnsGuru.generate(:app => 'www', :stage => 'production', :brand => 'google', :tld => 'com')) 
	end

	def test_rewrite
		assert_equal("www.mmp.com",  DnsGuru.rewrite("www.google.com", :brand => 'mmp')) 
		assert_equal("mail.google.com",  DnsGuru.rewrite("www.google.com", :app => 'mail')) 
		assert_equal("www.google.co.jp",  DnsGuru.rewrite("www.google.com", :tld => 'co.jp')) # this is iffy
		assert_equal(nil,  DnsGuru.rewrite("www.google.com", :stage => 'asdf')) 
	end

end
