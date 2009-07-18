#!/usr/bin/ruby

require 'rubygems'
require 'json_store'

# If you say "peekaboo" to him, he replies back "thppp".

# If you @reply him three times, he adds you as a friend.

# Then when you say "peekaboo", he says "peekaboo".

# Once you're friends, tag anythign #tadbird and he'll retweet it.

class Tadbird
  def initialize
    @data = JSONStore.new("tadbird.json")
  end

  def add_tweet(tweet)
    user = tweet[:user]
    text = tweet[:text]

    @data["tweets"] ||= []
    @data["tweets"] << text

    @data["counts"] ||= {}
    @data["counts"][user] ||= 0
    @data["counts"][user] += 1

    @data.save
  end
end

tad = Tadbird.new

tad.add_tweet(:user => "deisinger", :text => "PEEKABOO")