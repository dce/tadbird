#!/usr/bin/env ruby

require 'tadbird'

tad = Tadbird.new(ARGV[0], ARGV[1])
tad.add_peekaboos
tad.save