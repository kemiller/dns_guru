
module DnsGuru
	module RequestMixin

		def canonical_host_name(options = {})
			DnsGuru.generate(host_name_params.merge(options))
		end

		def host_name_params
			@host_name_params ||= DnsGuru.match(host) || DnsGuru.defaults
		end

	end
end
