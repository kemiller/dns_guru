
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

		def test_match_hit
			str = "mymatch_here"
			matcher = Matcher.new([m1 = MockPattern.new(true), m2 = MockPattern.new])
			matcher.match(str)
			assert_equal str, m1.got_match, "First Pattern wasn't checked"
			assert_equal nil, m2.got_match, "Second Pattern should not have been checked"
		end

		def test_generate_no_hit
			str = "mygenerate_here"
			generateer = Matcher.new([m1 = MockPattern.new, m2 = MockPattern.new])
			generateer.generate(str)
			assert_equal str, m1.got_generate, "First Pattern wasn't checked"
			assert_equal str, m2.got_generate, "Second Pattern wasn't checked"
		end

		def test_generate_hit
			str = "mygenerate_here"
			generateer = Matcher.new([m1 = MockPattern.new(true), m2 = MockPattern.new])
			generateer.generate(str)
			assert_equal str, m1.got_generate, "First Pattern wasn't checked"
			assert_equal nil, m2.got_generate, "Second Pattern should not have been checked"
		end

		def test_switch_no_hit
			str = "myswitch_here"
			opts = { :foo => 'bar' }
			switcher = Matcher.new([m1 = MockPattern.new, m2 = MockPattern.new])
			switcher.switch(str, opts)
			assert_equal [str, opts], m1.got_switch, "First Pattern wasn't checked"
			assert_equal [str, opts], m2.got_switch, "Second Pattern wasn't checked"
		end

		def test_switch_hit
			str = "myswitch_here"
			opts = { :foo => 'bar' }
			switcher = Matcher.new([m1 = MockPattern.new(true), m2 = MockPattern.new])
			switcher.switch(str, opts)
			assert_equal [str, opts], m1.got_switch, "First Pattern wasn't checked"
			assert_equal nil, m2.got_switch, "Second Pattern should not have been checked"
		end

		def test_pattern
			matcher = Matcher.new([])
			matcher.pattern ":asdf.:rase", :param => 'p1'
			assert_kind_of Pattern, matcher.patterns.first, "Didn't make a pattern"
		end

	end

	class MockPattern
		attr_reader :got_match, :got_generate, :got_switch

		def initialize(rval = false)
			@rval = rval
		end

		def match(string)
			@got_match = string
			@rval
		end

		def generate(options)
			@got_generate = options
			@rval
		end

		def switch(string, options)
			@got_switch = [string, options]
			@rval
		end
	end
end

