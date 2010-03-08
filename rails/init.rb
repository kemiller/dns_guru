
$: << File.join(File.dirname(__FILE__), "lib")
require 'dns_guru'
require 'rack'
require 'action_controller/test_process'

config_file = File.join(File.dirname(__FILE__), "../../../config/hosts.rb")
DnsGuru.init(config_file)

class Rack::Request
	include DnsGuru::RequestMixin
end

class ActionController::Request 
	include DnsGuru::RequestMixin
end

class ActionController::TestRequest 
	include DnsGuru::RequestMixin
end

class ActionController::Base
	include DnsGuru::ControllerMixin

	helper_method :host_name
	helper_method :host_name_params
end
