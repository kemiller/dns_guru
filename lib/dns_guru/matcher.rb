

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

	end

end
