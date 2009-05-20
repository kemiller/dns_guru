
require 'test/unit'
require 'dns_guru/request_mixin'

module DnsGuru
	class TestRequestMixin < Test::Unit::TestCase

		def setup
			DnsGuru.init(File.join(File.dirname(__FILE__), "../config.rb"))
			@req = MockRequest.new
		end

		def test_canonical_host_name
			@req.host = "www.production.mamapedia.com"
			assert_equal "www.mamapedia.com", @req.canonical_host_name
		end

		def test_host_name_params
			@req.host = "www.production.mamapedia.com"
			assert_equal({:app => 'www', :stage => 'production', :brand => 'mamapedia', :tld => 'com'},
				@req.host_name_params, "Wrong host name components derived from raw host name")
		end
	end


	class MockRequest
		include RequestMixin
		attr_accessor :host
	end
end
