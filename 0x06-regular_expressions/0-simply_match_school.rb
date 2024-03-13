#!/usr/bin/env ruby
# A Ruby script employing a regular expression that must match the term 'School'
puts ARGV[0].scan(/School/).join
