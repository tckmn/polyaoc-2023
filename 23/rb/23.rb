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

v = cpnts.filter_map.with_index{|size, idx| idx if size == 1}
e = cpnts.filter_map.with_index{|size, idx| idx if size != 1}
edges = []
while y = g.index{|row| x = row.index{|ch| %w[> < ^ v].include? ch }}
    case g[y][x]
    when ?> then edges.push [g[y][x-1], g[y][x+1]]
    when ?< then edges.push [g[y][x+1], g[y][x-1]]
    when ?v then edges.push [g[y-1][x], g[y+1][x]]
    when ?^ then edges.push [g[y+1][x], g[y-1][x]]
    end
    g[y][x] = ?#
end

dedges = v.map{[]}
uedges = v.map{[]}
st, fn = nil, nil
extra = 0
e.each do |idx|
    src = edges.rassoc idx
    src = v.index src[0] if src
    dst = edges.assoc idx
    dst = v.index dst[1] if dst
    if src && dst
        dedges[src].push [dst, cpnts[idx]]
        uedges[src].push [dst, cpnts[idx]]
        uedges[dst].push [src, cpnts[idx]]
    else
        st ||= dst
        fn ||= src
        extra += cpnts[idx]+1
    end
end

def longest edges, st, fn, used
    return 0 if st == fn
    pobs = edges[st].filter_map{|dst, w|
        if used & (1 << dst) == 0
            ret = longest(edges, dst, fn, used | (1 << st))
            ret && w + 3 + ret
        end
    }
    pobs.empty? ? nil : pobs.max
end

# part 1
p extra + longest(dedges, st, fn, 0)

# part 2
p extra + longest(uedges, st, fn, 0)
