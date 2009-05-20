
$: << File.join(File.dirname(__FILE__), "lib")
require 'dns_guru'

config_file = File.join(File.dirname(__FILE__), "../../../config/hosts.rb")
DnsGuru.init(config_file)

class ActionController::CgiRequest
	include DnsGuru::RequestMixin
end

class ActionController::Base
	include DnsGuru::ControllerMixin
end
