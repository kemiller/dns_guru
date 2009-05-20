
module DnsGuru
	module ControllerMixin
		def host_name(options = {})
			host = request.canonical_host_name(options)
			if request.port && request.port != 80
				host = "#{host}:#{request.port}"
			end
			host
		end
		def host_name_params
			request.host_name_params
		end
	end
end
