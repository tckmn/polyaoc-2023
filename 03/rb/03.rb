#!/usr/bin/env ruby

g = File.readlines('input').map{|line| line.chomp.chars }
g = [g[0].map{?.}, *g, g[0].map{?.}].map{|r| [?., *r, ?.]}
adj = [-1,0,1].product([-1,0,1]) - [[0,0]]

def num c; '0' <= c && c <= '9'; end

p1 = 0
p2 = 0
fullused = Hash.new{|h,v|h[v]=[]}

x=x # silly
while y = g.index{|r| x = r.index{|c| !(num(c) || c == ?.) }}
    partused = Hash.new{|h,v|h[v]=[]}
    ns = []

    adj.each do |dy,dx|
        yy,xx = y+dy,x+dx
        if num(g[yy][xx]) && !partused[yy].include?(xx)
            lx,hx = xx,xx
            lx -= 1 while num g[yy][lx-1]
            hx += 1 while num g[yy][hx+1]
            n = g[yy][lx..hx].join.to_i
            ns.push n
            p1 += n unless fullused[yy].include?(xx)
            partused[yy].push *lx..hx
            fullused[yy].push *lx..hx
        end
    end
    p2 += ns[0]*ns[1] if ns.size == 2

    g[y][x] = ?.
end

puts p1
puts p2
