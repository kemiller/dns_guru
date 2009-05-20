
require 'dns_guru/pattern'

module DnsGuru
	class Matcher

		attr_reader :patterns

		def initialize(patterns)
			@patterns = patterns
		end

		def match(string)
			iterate(:match, string)
		end

		def generate(options)
			iterate(:generate, options)
		end

		def switch(string, options = {})
			iterate(:switch, string, options)
		end

		def pattern(pattern_string, params = {})
			@patterns << Pattern.new(pattern_string, params)
		end

		protected

		def iterate(method, *args)
			@patterns.each do |p|
				m = p.send(method, *args)
				return m if m
			end
		end

	end

end
