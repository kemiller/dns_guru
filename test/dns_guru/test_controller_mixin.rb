
require 'test/unit'
require 'dns_guru'

module DnsGuru
	class TestControllerMixin < Test::Unit::TestCase

		def setup
			DnsGuru.init(File.join(File.dirname(__FILE__), "../config.rb"))
			@request = MockRequest.new
			@controller = MockController.new
			@controller.request = @request
		end

		def test_host_name
			@request.host = "www.production.mmp.com"
			assert_equal "www.mmp.com", @controller.host_name
		end

		def test_host_name_with_port
			@request.host = "www.production.mmp.com"
			@request.port = 3000
			assert_equal "www.mmp.com:3000", @controller.host_name
		end

		def test_host_name_params
			@request.host = "www.production.mamapedia.com"
			assert_equal({:app => 'www', :stage => 'production', :brand => 'mamapedia', :tld => 'com'},
				@controller.host_name_params, "Wrong host name components derived from raw host name")
		end

		def test_host_name_params_no_host
			assert_equal({:app => 'www', :stage => 'production', :brand => 'mmp', :tld => 'com'},
				@controller.host_name_params, "No default values given")
		end
	end

	class MockRequest
		include RequestMixin
		attr_accessor :host
		attr_accessor :port
	end

	class MockController
		include ControllerMixin
		attr_accessor :request
	end
end
