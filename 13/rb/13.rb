#!/usr/bin/env ruby

def syms g
    (0...g.size-1).select{|i|
        (0..g.size).all?{|d|
            a,b = i+1+d,i-d
            a >= g.size || b < 0 || g[a] == g[b]
        }
    }
end

def both g, x=nil, y=nil
    g[x][y] = g[x][y] == ?# ? ?. : ?# if x
    row = syms g
    col = syms g.transpose
    g[x][y] = g[x][y] == ?# ? ?. : ?# if x
    row.map{|r| ((r+1)*100)} + col.map{|c| c+1}
end

# both parts
puts File.read('input').split("\n\n").map{|board|
    g = board.lines.map{|line| line.chomp.chars }
    old = both(g)[0]
    news = (0...g.size).flat_map do |x|
        (0...g[0].size).flat_map do |y|
            both g, x, y
        end
    end
    [old, news.find{|x|x!=old}]
}.transpose.map &:sum
