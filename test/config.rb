
DnsGuru.read do |matcher|
	matcher.pattern ":app.:brand.:tld", :stage => 'development'
end

