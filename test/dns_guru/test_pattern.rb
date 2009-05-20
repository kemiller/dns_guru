
require 'test/unit'
require 'dns_guru'

module DnsGuru
	class TestPattern < Test::Unit::TestCase

		def test_initialize
			p = Pattern.new(":blah.:blah")
			assert_not_nil p, "Initialization should work"
		end

		def test_parse
			p = Pattern.new(":blah.:blah")
			segments = p.segments
			assert !segments.empty?, "Parsing should return an array of segments"
		end

		def test_segment_types
			p = Pattern.new(":blah.dev.:blah")
			segments = p.segments
			assert_kind_of DynamicSegment, segments.first, "First Segment should be Dynamic"
			assert_kind_of StaticSegment, segments[1], "Second Segment should be Static"
		end

		def test_match
			p = Pattern.new(":app.:stage.:brand.:tld")
			assert_equal({ :app => 'www', :stage => 'dev', :brand => 'mmp', :tld => 'com' },  p.match("www.dev.mmp.com"))
			assert_equal({ :app => 'www-01', :stage => 'dev', :brand => 'mmp', :tld => 'com' },  p.match("www-01.dev.mmp.com"))
		end

		def test_match_with_static_segments
			p = Pattern.new(":app.dev.:brand.:tld", :stage => 'development')
			assert_equal({ :app => 'www', :stage => 'development', :brand => 'mmp', :tld => 'com' },  p.match("www.dev.mmp.com"))
		end

		def test_match_no_match
			p = Pattern.new("foo")
			assert_equal(nil,  p.match("ausfark"))
		end

		def test_localhost
			p = Pattern.new("localhost", :stage => 'development', :brand => 'mms', :tld => 'com', :app => 'www')
			assert_equal({ :app => 'www', :stage => 'development', :brand => 'mms', :tld => 'com' },  p.match("localhost"))
		end

		def test_generate
			p = Pattern.new(":app.:stage.:brand.:tld")
			assert_equal "www.qa.mms.com", p.generate(:app => 'www', :stage => 'qa', :brand => 'mms', :tld => 'com')
		end

		def test_generate_with_defaults
			p = Pattern.new(":app.:stage.:brand.:tld", :tld => 'com')
			assert_equal "www.qa.mms.com", p.generate(:app => 'www', :stage => 'qa', :brand => 'mms')
		end

		def test_generate_with_statics
			p = Pattern.new(":app.dev.:brand.:tld", :stage => 'development')
			assert_equal "www.dev.mms.com", p.generate(:app => 'www', :stage => 'development', :brand => 'mms', :tld => 'com')
		end

		def test_generate_fails_for_insufficient_params
			p = Pattern.new(":app.dev.:brand.:tld", :stage => 'development')
			assert_equal nil, p.generate(:stage => 'development', :brand => 'mms', :tld => 'com')
		end

		def test_generate_fails_for_surplus_params
			p = Pattern.new(":app.dev.:brand.:tld", :stage => 'development')
			assert_equal nil, p.generate(:extra => 'foo', :app => 'www', :stage => 'development', :brand => 'mms', :tld => 'com')
		end

		def test_rewrite
			p = Pattern.new(":app.:stage.:brand.:tld")
			assert_equal "www.qa.mmp.com", p.rewrite("www.qa.google.com", :brand => 'mmp')
		end

	end
end
