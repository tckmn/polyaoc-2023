#!/usr/bin/env ruby

require 'set'

@g = File.readlines('input').map{|line| line.chomp.chars }

def fd yy,xx,d
    case @g[yy][xx]
    when ?/ then [[yy,xx,{r: :u, u: :r, d: :l, l: :d}[d]]]
    when ?\\ then [[yy,xx,{r: :d, d: :r, l: :u, u: :l}[d]]]
    when ?| then d == :r || d == :l ? [[yy,xx,:u], [yy,xx,:d]] : [[yy,xx,d]]
    when ?- then d == :r || d == :l ? [[yy,xx,d]] : [[yy,xx,:r], [yy,xx,:l]]
    when ?. then [[yy,xx,d]]
    end
end

def doit y,x,d
    beams = fd y,x,d
    en = @g.map{|x|x.map{false}}
    done = @g.map{|x|x.map{Set.new}}
    until beams.empty?
        y,x,d = beams.shift
        en[y][x] = true
        next if done[y][x].include? d
        done[y][x].add(d)
        yy,xx = case d
                when :r then [y,x+1]
                when :l then [y,x-1]
                when :u then [y-1,x]
                when :d then [y+1,x]
                end
        next if yy < 0 || xx < 0 || yy >= @g.size || xx >= @g[0].size
        beams.concat fd(yy,xx,d)
    end
    en.flatten.count true
end

# part 1
p doit(0,0,:r)

# part 2
p ((0...@g.size).flat_map{|y|
    [doit(y, 0, :r), doit(y, @g[0].size-1, :l)]
} + (0...@g[0].size).flat_map{|x|
    [doit(0, x, :d), doit(@g.size-1, x, :u)]
}).max
