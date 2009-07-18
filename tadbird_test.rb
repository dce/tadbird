require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'tadbird'

class TadbirdTest < Test::Unit::TestCase
  context "A Tadbird" do
    setup do
      @tad = Tadbird.new("tadbird_test.json")
    end

    should "have a count of zero for user by default" do
      assert_equal 0, @tad.counts["deisinger"]
    end

    should "have an empty list of tweets by default" do
      assert_equal [], @tad.tweets
    end

    context "with a tweet" do
      setup do
        @tad.add_tweet(:user => "deisinger", :text => "PEEKABOO")
      end

      should "store a count of tweets by user" do
        assert_equal 1, @tad.counts["deisinger"]
      end

      should "store a list of tweets" do
        assert_equal ["PEEKABOO"], @tad.tweets
      end

      should "handle multiple tweets properly" do
        @tad.add_tweet(:user => "krestashin", :text => "PEEKABOO")
        @tad.add_tweet(:user => "deisinger",  :text => "OHAI")

        assert_equal 2, @tad.counts["deisinger"]
        assert_equal 1, @tad. counts["krestashin"]
        assert_equal ["PEEKABOO", "PEEKABOO", "OHAI"], @tad.tweets
      end

      teardown do
        File.delete("tadbird_test.json")
      end
    end
  end
end