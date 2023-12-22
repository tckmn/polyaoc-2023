#!/usr/bin/env ruby

def bads arr
    arr.filter_map.with_index{|row,i| i if row.all?{|x|x==?.} }
end

g = File.readlines('input').map{|line| line.chomp.chars }
badrows = bads g
badcols = bads g.transpose
coords = g.flat_map.with_index{|row,i| row.filter_map.with_index{|x,j| [i,j] if x == ?# }}

# both parts
[1, 999999].each do |penalty|
    p coords.combination(2).map{|a,b|
        lx,hx,ly,hy = a.zip(b).flat_map(&:sort)
        hx-lx + hy-ly + penalty * (badrows.count{|r| lx<r && r<hx } + badcols.count{|c| ly<c && c<hy })
    }.sum
end
