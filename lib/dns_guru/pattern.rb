
module DnsGuru
	class Pattern

		attr_reader :segments, :regexp, :params

		def initialize(pattern, params={})
			parse(pattern)
			@params = params
		end

		def parse(pattern)
			raw_segments = pattern.split(/\./)

			@segments = raw_segments.map do |seg| 
				if seg =~ /\A:(.*)/
					DynamicSegment.new($1)
				else
					StaticSegment.new(seg)
				end
			end.compact
 
			@regexp = /\A#{segments.map { |s| s.substitute }.join('\.')}\Z/
		end

		def match(string)
			md = @regexp.match(string)

			hash = {}
			md.captures.each_with_index do |m, i|
				if segments[i].param
					hash[segments[i].param] = m 
				end
			end

			params.merge(hash)
		end

		def generate(options)
			hostname = segments.map do |seg|
				seg.generate(options)
			end

			if hostname.include?(nil)
				return nil
			end

			# Whatever is left should be identical
			if params == options
				return hostname.join('.')
			end

		end

		def rewrite(domain, new_options)
			options = match(domain)
			generate(options.merge(new_options))
		end
	end

	class Segment
		def initialize(string)
			@string = string
		end

		def param
			nil
		end
	end

	class DynamicSegment < Segment
		def substitute
			"([[:alnum:]_-]+)"
		end

		def generate(options)
			unless options[param]
				return nil
			end
			options.delete(param)
		end

		def param
			@string.to_sym
		end
	end

	class StaticSegment < Segment
		def substitute
			"(#{@string})"
		end

		def generate(options)
			@string
		end
	end
end

