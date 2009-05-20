
require 'dns_guru/matcher'

module DnsGuru

	def self.init(filename)
		@matcher = Matcher.new([])
		load filename
	end

	def self.read
		yield(@matcher)
	end

	def self.match(domain)
		@matcher.match(domain)
	end

	def self.generate(options)
		@matcher.generate(options)
	end

	def self.rewrite(domain, options)
		@matcher.rewrite(domain, options)
	end
end
