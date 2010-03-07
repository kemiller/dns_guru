
module DnsGuru
	class Pattern

		attr_reader :segments, :regexp, :params

		def initialize(pattern, params={})
			@params = params
			parse(pattern)
		end

		def parse(pattern)
			raw_segments = pattern.split(/(\.|-)/)

			@segments = raw_segments.map do |seg| 
				Segment.make_segment(seg, @params)
			end
 
			@regexp = /\A#{segments.map { |s| s.substitute }.join}\Z/
		end

		def match(string)
			md = @regexp.match(string)

			unless md
				return nil
			end

			hash = {}
			md.captures.each_with_index do |m, i|
				if segments[i].param
					hash[segments[i].param] = m 
				end
			end

			params.merge(hash)
		end

		def generate(options)
			options = options.dup
			hostname = segments.map do |seg|
				seg.generate(options)
			end

			if hostname.include?(nil)
				return nil
			end

			# Whatever is left should be identical
			if params == options
				return hostname.join
			end
		end

		def rewrite(domain, new_options)
			options = match(domain)
			if options
				generate(options.merge(new_options))
			end
		end
	end

	class Segment

		class << self
			def inherited(klass)
				types << klass
			end

			def types
				@types ||= []
			end

			def make_segment(string, params = {})
				klass = types.detect do |t|
					t.recognize(string)
				end
				klass.new(string, params)
			end
		end

		def initialize(string, params = {})
			@string = string
			@default = params.delete(param)
		end

		def param
			nil
		end

	end

	class DynamicSegment < Segment
		def self.recognize(string_segment)
			string_segment =~ /\A:(.*)/
		end

		def substitute
			"([[:alnum:]_-]+)"
		end

		def generate(options)
			unless options[param]
				return @default
			end
			options.delete(param)
		end

		def param
			@param ||= @string[1,1000].to_sym
		end
	end

	class StaticSegment < Segment
		def self.recognize(string_segment)
			true
		end

		def substitute
			"(#{Regexp.escape(@string)})"
		end

		def generate(options)
			@string
		end
	end
end

