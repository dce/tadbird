#!/usr/bin/ruby

require 'rubygems'
require 'json_store'

# If you say "peekaboo" to him, he replies back "thppp".

# If you @reply him three times, he adds you as a friend.

# Then when you say "peekaboo", he says "peekaboo".

# Once you're friends, tag anythign #tadbird and he'll retweet it.

class Tadbird
  def initialize(file = "tadbird.json")
    @data = JSONStore.new(file)
  end

  def tweet_exists?(tweet)
    tweets.keys.include? tweet[:id]
  end

  def add_tweet(tweet)
    tweets[tweet[:id]] = tweet unless tweet_exists? tweet
  end

  def counts
    tweets.values.inject(Hash.new(0)) do |sums, tweet|
      sums[tweet[:user]] ||= 0
      sums[tweet[:user]] += 1
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
