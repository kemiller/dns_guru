
$: << File.join(File.dirname(__FILE__), "lib")
require 'dns_guru'

config_file = File.join(File.dirname(__FILE__), "../../../config/host_patterns.rb")
DnsGuru.init(config_file)

class ActionController::Request
	include DnsGuru::RequestMixin
end

class ActionController::Base
	include DnsGuru::ControllerMixin
end
