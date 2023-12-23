#!/usr/bin/env ruby

def hsh s
    s.chars.reduce(0) {|h, ch| ((h + ch.ord) * 17) % 256 }
end

ins = File.read('input').chomp.split ?,

# part 1
puts ins.map{|s| hsh s }.sum

# part 2
boxes = Array.new(256) {[]}
ins.each do |s|
    thing = s.scan(/[a-z]+/)[0]
    h = hsh thing
    if s[-1] == ?-
        boxes[h].reject!{|x| x[0] == thing }
    else
        idx = boxes[h].index{|x| x[0] == thing } || boxes[h].size
        boxes[h][idx] = [thing, s.split(?=)[1].to_i]
    end
end

p boxes.map.with_index{|box,idx|
    box.map.with_index{|x, j|
        (idx+1) * (j+1) * x[1]
    }.sum
}.sum
