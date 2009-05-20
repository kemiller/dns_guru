
DnsGuru.read do |matcher|
	matcher.pattern "localhost", :app => 'www', :stage => 'development', :brand => 'mamasource', :tld => 'com'
	matcher.pattern "seodev.:brand.:tld", :stage => 'qa'
	matcher.pattern ":app.:brand.:tld", :stage => 'production'
	matcher.pattern ":app.:stage.:brand.:tld", :app => 'www', :stage => 'production', :brand => 'mmp', :tld => 'com'
end
