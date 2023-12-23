#!/usr/bin/env ruby

# both parts
*p1, p2 = File.readlines('input').map{|line|
    line.scan(/\d+/).map(&:to_i).tap{|a| a.push a.join.to_i }
}.transpose.map{|t, d|
    x = Math.sqrt(t*t - 4*d)
    ((t+x)/2).ceil - ((t-x)/2).floor - 1
}

puts p1.reduce :*
puts p2
