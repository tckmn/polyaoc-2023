#!/usr/bin/env ruby

def roll line
    line.join.split(?#,-1).map{|p| ?O * p.count(?O) + ?. * p.count(?.)}.join(?#).chars
end

def revroll line
    line.join.split(?#,-1).map{|p| ?. * p.count(?.) + ?O * p.count(?O)}.join(?#).chars
end

def ans g
    g.reverse.map.with_index{|line,i| line.count(?O)*(i+1)}.sum
end

g = File.readlines('input').map{|line| line.chomp.chars }

# part 1
p ans g.transpose.map{|line| roll line }.transpose

# part 2
had = {}
ns = {}
ttl = 1000000000
(0..).each do |i|
    g = g.transpose.map{|line| roll line }.transpose
    g = g.map{|line| roll line }
    g = g.transpose.map{|line| revroll line }.transpose
    g = g.map{|line| revroll line }

    thing = g.map(&:join).join
    if had.include? thing
        cycle = i - had[thing]
        p ns[had[thing] + ((ttl - had[thing]) % cycle) - 1]
        exit
    end
    had[thing] = i
    ns[i] = ans g
end
