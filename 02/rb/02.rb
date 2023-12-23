#!/usr/bin/env ruby

# both parts
p File.readlines('input').map{|line|
    gid = line.match(/\d+/)[0].to_i
    good = line.split(': ')[1].split('; ').map{|x|
        hsh = x.split(', ').map{|kv| kv.split.reverse}.to_h
        %w[red green blue].map{|c| hsh.fetch(c, 0).to_i}
    }
    red = good.reduce{|a,b| a.zip(b).map &:max}
    [red[0]<=12 && red[1]<=13 && red[2]<=14 ? gid : 0, red.reduce(:*)]
}.transpose.map &:sum
