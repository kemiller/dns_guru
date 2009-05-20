
require 'dns_guru/matcher'
require 'test/unit'

module DnsGuru
	class TestMatcher < Test::Unit::TestCase

		def test_truth
			Matcher
		end

		def test_initialize
			matcher = Matcher.new([])
			assert_not_nil matcher
		end

		def test_match_no_hit
			str = "mymatch_here"
			matcher = Matcher.new([m1 = MockPattern.new, m2 = MockPattern.new])
			matcher.match(str)
			assert_equal str, m1.got_match, "First Pattern wasn't checked"
			assert_equal str, m2.got_match, "Second Pattern wasn't checked"
		end

		def test_match_no_hit
			str = "mymatch_here"
			matcher = Matcher.new([m1 = MockPattern.new(true), m2 = MockPattern.new])
			matcher.match(str)
			assert_equal str, m1.got_match, "First Pattern wasn't checked"
			assert_equal nil, m2.got_match, "Second Pattern should not have been checked"
		end
	end

	class MockPattern
		attr_reader :got_match

		def initialize(rval = false)
			@rval = rval
		end

		def match(string)
			@got_match = string
			@rval
		end
	end
end

