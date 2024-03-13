#!/usr/bin/env ruby
# A Ruby script that uses a regular expression that matches a given pattern
puts ARGV[0].scan(/hbt{2,5}n/).join
