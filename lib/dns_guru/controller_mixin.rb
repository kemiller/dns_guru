
module DnsGuru
	module ControllerMixin
		def host_name(options = {})
			request.canonical_host_name(options)
		end
		def host_name_params
			request.host_name_params
		end
	end
end
