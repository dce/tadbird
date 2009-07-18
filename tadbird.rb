require 'rubygems'
require 'json_store'
require 'twitter'

class Tadbird
  def initialize(username, password, file = "tadbird.json")
    auth = Twitter::HTTPAuth.new(username, password)
    @twitter = Twitter::Base.new(auth)
    @data = JSONStore.new(file)
  end

  def tweet_exists?(tweet)
    tweets.keys.include?(tweet["id"].to_s)
  end

  def add_tweet(tweet)
    tweets[tweet["id"].to_s] = tweet unless tweet_exists?(tweet)
  end

  def add_peekaboos
    Twitter::Search.new("@tadbird peekaboo").each do |tweet|
      if add_tweet(tweet)
        user = tweet["from_user"]
        add_friend(user) if counts[user] > 2
        peekaboo_to(user)
      end
    end
  end

  def counts
    tweets.values.inject(Hash.new(0)) do |sums, tweet|
      sums[tweet["from_user"]] += 1
      sums
    end
  end

  def peekaboo_to(user)
    msg = if counts[user] > 2
      "PEEKABOO"
    else
      str = proc { "thpp#{ "p" * rand(3) }" }
      (1..(rand(3) + 1)).map { str.call } * " "
    end
    @twitter.update("@#{user} #{msg}")
  end

  def friends
    @friends ||= @twitter.friends.map {|f| f.screen_name }
  end

  def add_friend(user)
    unless friends.include?(user)
      @twitter.friendship_create(user)
      @friends = nil
    end
  end

  def tweets
    @data["tweets"] ||= {}
  end

  def save
    @data.save
  end
end
