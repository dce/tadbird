#!/usr/bin/ruby

require 'rubygems'
require 'json_store'
require 'twitter'

# If you say "peekaboo" to him, he replies back "thppp".

# If you @reply him three times, he adds you as a friend.

# Then when you say "peekaboo", he says "peekaboo".

# Once you're friends, tag anythign #tadbird and he'll retweet it.

class Tadbird
  def initialize(file = "tadbird.json")
    @data = JSONStore.new(file)
  end

  def tweet_exists?(tweet)
    tweets.keys.include?(tweet["id"])
  end

  def add_tweet(tweet)
    tweets[tweet["id"]] = tweet unless tweet_exists?(tweet)
  end

  def add_peekaboos
    Twitter::Search.new("@tadbird peekaboo").each do |tweet|
      if add_tweet(tweet)
        p "friendship!" if counts[tweet["from_user"]] == 3
      end
    end
  end

  def counts
    tweets.values.inject(Hash.new(0)) do |sums, tweet|
      sums[tweet["from_user"]] += 1
      sums
    end
  end

  def tweets
    @data["tweets"] ||= {}
  end

  def save
    @data.save
  end
end
