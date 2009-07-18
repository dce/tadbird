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

  def add_tweet(tweet)
    counts[tweet[:user]] += 1
    tweets << tweet[:text]
    @data.save
  end

  def counts
    @data["counts"] ||= Hash.new(0)
  end

  def tweets
    @data["tweets"] ||= []
  end
end
