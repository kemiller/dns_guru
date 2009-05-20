
require 'test/unit'
require 'dns_guru/pattern'

class DnsGuru::TestPattern < Test::Unit::TestCase

	def test_initialize
		p = DnsGuru::Pattern.new(":blah.:blah")
		assert_not_nil p, "Initialization should work"
	end

	def test_parse
		p = DnsGuru::Pattern.new(":blah.:blah")
		segments = p.segments
		assert !segments.empty?, "Parsing should return an array of segments"
	end

	def test_segment_types
		p = DnsGuru::Pattern.new(":blah.dev.:blah")
		segments = p.segments
		assert_kind_of DnsGuru::DynamicSegment, segments.first, "First Segment should be Dynamic"
		assert_kind_of DnsGuru::StaticSegment, segments[1], "Second Segment should be Static"
	end

	def test_match
		p = DnsGuru::Pattern.new(":app.:stage.:brand.:tld")
		assert_equal({ :app => 'www', :stage => 'dev', :brand => 'mmp', :tld => 'com' },  p.match("www.dev.mmp.com"))
		assert_equal({ :app => 'www-01', :stage => 'dev', :brand => 'mmp', :tld => 'com' },  p.match("www-01.dev.mmp.com"))
	end

	def test_match_with_static_segments
		p = DnsGuru::Pattern.new(":app.dev.:brand.:tld", :stage => 'development')
		assert_equal({ :app => 'www', :stage => 'development', :brand => 'mmp', :tld => 'com' },  p.match("www.dev.mmp.com"))
	end

	def test_localhost
		p = DnsGuru::Pattern.new("localhost", :stage => 'development', :brand => 'mms', :tld => 'com', :app => 'www')
		assert_equal({ :app => 'www', :stage => 'development', :brand => 'mms', :tld => 'com' },  p.match("localhost"))
	end
end
