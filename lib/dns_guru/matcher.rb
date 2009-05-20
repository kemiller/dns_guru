
require 'dns_guru/pattern'

module DnsGuru
	class Matcher

		attr_reader :patterns

		def initialize(patterns)
			@patterns = patterns
		end

		def match(string)
			@patterns.each do |p|
				m = p.match(string)
				return m if m
			end
		end

		def pattern(pattern_string, params = {})
			@patterns << Pattern.new(pattern_string, params)
		end

	end

end
