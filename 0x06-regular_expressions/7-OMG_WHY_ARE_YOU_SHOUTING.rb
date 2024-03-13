#!/usr/bin/env ruby
# A Ruby script that uses a regular expression that matches only capital letters
puts ARGV[0].scan(/[A-Z]/).join
