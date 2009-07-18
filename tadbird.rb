#!/usr/bin/ruby

require 'rubygems'
require 'json'

# If you say "peekaboo" to him, he replies back "thppp".

# If you @reply him three times, he adds you as a friend.

# Then when you say "peekaboo", he says "peekaboo".

# Once you're friends, tag anythign #tadbird and he'll retweet it.

data = JSON.parse(File.open("tadbird.json").read)

raise data .inspect