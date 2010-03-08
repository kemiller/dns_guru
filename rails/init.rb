
$: << File.join(File.dirname(__FILE__), "lib")
require 'dns_guru'
require 'rack'
require 'action_controller/test_process'

begin
	config_files = [
		File.join(File.dirname(__FILE__), "..","..","..","config","hosts.rb"),
		File.join(File.dirname(__FILE__), "..","..","..","..","config","hosts.rb")
	]
	if Object.const_defined?(:Rails)
		config_files << File.join(Rails.root, "config","hosts.rb")
	end
	config_files.detect do |config_file|
		if File.exists?(config_file)
			DnsGuru.init(config_file)
			true
		end
	end
rescue Exception => e
	puts "Could not load dns_guru config file (hosts.rb): #{e}"
end

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
