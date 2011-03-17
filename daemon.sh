#!/usr/bin/ruby

# 
# Start the facebook tunnel
#

c = "cd " + File.dirname(__FILE__) + "; /usr/bin/rake facebooker:tunnel:background_start"
puts c
x = system(c)