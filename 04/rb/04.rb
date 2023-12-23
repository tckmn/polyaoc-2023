#!/usr/bin/env ruby

p1 = 0
p2 = 0
lines = File.readlines 'input'
copies = lines.map{1}

lines.each do |line|
    a,b = line.split(?:)[1].split(?|).map{|x| x.split.map &:to_i}
    n = b.count{|x| a.include? x}

    p1 += 2**(n-1) if n>0
    p2 += c = copies.shift
    copies = copies[0...n].map{|i|i+c} + copies[n..-1]
end

puts p1
puts p2
