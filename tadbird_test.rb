require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'tadbird'

class TadbirdTest < Test::Unit::TestCase
  context "A Tadbird" do
    setup do
      @tad = Tadbird.new("username", "password", "tadbird_test.json")
    end

    context "by default" do
      should "have a count of zero for user" do
        assert_equal 0, @tad.counts["deisinger"]
      end

      should "have an empty list of tweets" do
        assert_equal({}, @tad.tweets)
      end
    end

    context "adding a tweet" do
      should "require search terms" do
        @tad.add_tweet tweet("text" => "wrong!")
        assert_equal 0, @tad.tweets.size
      end

      should "require ALL search terms" do
        @tad.add_tweet tweet("text" => "peekaboo")
        assert_equal 0, @tad.tweets.size
      end

      should "ignore search order" do
        @tad.add_tweet tweet("id" => 1, "text" => "@tadbird peekaboo")
        @tad.add_tweet tweet("id" => 2, "text" => "peekaboo @tadbird")
        assert_equal 2, @tad.tweets.size
      end

      should "ignore capitalization" do
        @tad.add_tweet tweet("text" => "@tadbird pEEkabOO")
        assert_equal 1, @tad.tweets.size
      end
    end


    context "with a tweet" do
      setup do
        @tad.add_tweet(tweet)
      end

      should "store a count of tweets by user" do
        assert_equal 1, @tad.counts["deisinger"]
      end

      should "store a list of tweets" do
        assert_equal({ "1" => tweet }, @tad.tweets)
      end

      should "not add the same tweet twice" do
        @tad.add_tweet(tweet)
        assert_equal 1, @tad.counts["deisinger"]
      end

      should "handle multiple tweets properly" do
        @tad.add_tweet(tweet("id" => 2, "from_user" => "krestashin"))
        @tad.add_tweet(tweet("id" => 3))

        assert_equal 2, @tad.counts["deisinger"]
        assert_equal 1, @tad.counts["krestashin"]
      end
    end
  end

  def tweet(opts = {})
    defaults = {
      "id"        => 1,
      "from_user" => "deisinger",
      "text"      => "@tadbird PEEKABOO"
    }

    defaults.merge(opts)
  end
end