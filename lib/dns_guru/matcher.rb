
require 'dns_guru/pattern'

module DnsGuru
	class Matcher

		attr_reader :patterns

		def initialize(patterns = [])
			@patterns = patterns
		end

		def match(string)
			iterate(:match, string)
		end

		def generate(options = {})
			@defaults ||= {}
			iterate(:generate, @defaults.merge(options))
		end

		def rewrite(string, options = {})
			params = match(string)
			if params
				generate(match(string).merge(options))
			else
				string
			end
		end

		def pattern(pattern_string, params = {})
			@patterns << Pattern.new(pattern_string, params)
		end

		def defaults(options = {})
			@defaults = options
		end

		def current_defaults
			@defaults
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
