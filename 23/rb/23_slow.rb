#!/usr/bin/env ruby

require 'set'

def flood g, sy, sx, v, adj=nil
    q = [[sy,sx]]
    seen = Set.new q
    size = 0
    until q.empty?
        y,x = q.shift
        size += 1
        g[y][x] = v
        [[1,0], [-1,0], [0,1], [0,-1]].each do |dx, dy|
            yy = y+dy
            xx = x+dx
            # the fact that this doesn't break with negative coordinates is subtle lol
            if g.dig(yy, xx) == ?. && !seen.include?([yy, xx])
                seen.add [yy, xx]
                q.push [yy, xx]
            end
        end
    end
    size
end


g = File.readlines('input').map{|line| line.chomp.chars }

cpnts = []
x = x # silly
while y = g.index{|row| x = row.index ?. }
    cpnts.push flood g, y, x, cpnts.size
end

dedges = Hash.new{|h,v| h[v] = Set.new}
uedges = Hash.new{|h,v| h[v] = Set.new}
while y = g.index{|row| x = row.index{|ch| %w[> < ^ v].include? ch }}
    src, dst = case g[y][x]
    when ?> then [g[y][x-1], g[y][x+1]]
    when ?< then [g[y][x+1], g[y][x-1]]
    when ?v then [g[y-1][x], g[y+1][x]]
    when ?^ then [g[y+1][x], g[y-1][x]]
    end
    dedges[src].add dst
    uedges[src].add dst
    uedges[dst].add src
    g[y][x] = ?#
end

st, fn = [0, -1].map{|i| g[i].find{|x| x.is_a? Integer }}

def longest cpnts, edges, st, fn, used
    return cpnts[fn] if st == fn
    newused = used + [st]
    pobs = edges[st].select{|dst| !used.include? dst}.map{|dst|
        longest cpnts, edges, dst, fn, newused
    }.compact
    pobs.empty? ? nil : cpnts[st]+1+pobs.max
end

p longest(cpnts, dedges, st, fn, []) - 1
p longest(cpnts, uedges, st, fn, []) - 1
