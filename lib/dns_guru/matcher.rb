
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

		def rewrite(string, options = {})
			generate(match(string).merge(options))
		end

		def pattern(pattern_string, params = {})
			@patterns << Pattern.new(pattern_string, params)
		end

		protected

		def iterate(method, *args)
			@patterns.each do |pat|
				val = pat.send(method, *args)
				if val
					return val
				end	
			end
			nil
		end

	end

end
