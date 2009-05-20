
$: << File.join(File.dirname(__FILE__), "lib")
require 'dns_guru'

config_file = File.join(File.dirname(__FILE__), "../../../config/hosts.rb")
DnsGuru.init(config_file)

class ActionController::AbstractRequest
	include DnsGuru::RequestMixin
	helper_method :host_name
	helper_method :host_name_params
end

class ActionController::Base
	include DnsGuru::ControllerMixin
end
