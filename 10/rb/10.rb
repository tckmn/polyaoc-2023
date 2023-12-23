#!/usr/bin/env ruby

require 'set'

g = File.readlines('input').map{|line| line.chomp.chars }
sx = g[sy = g.index{|line| line.include? ?S }].index ?S
sdy, sdx = '-LF'.include?(g[sy][sx-1] || ?.) ? [0,-1] :
           '-J7'.include?(g[sy][sx+1] || ?.) ? [0,1] : [1,0]

cs = [[sy, sx], [sy+sdy, sx+sdx]]

until cs[0] == cs[-1]
    y,x = cs[-1]
    py,px = cs[-2]
    y1,x1,y2,x2 = {
        ?- => [0,-1,0,1],
        ?| => [-1,0,1,0],
        ?L => [-1,0,0,1],
        ?F => [0,1,1,0],
        ?J => [-1,0,0,-1],
        ?7 => [0,-1,1,0]
    }[g[y][x]]
    if py == y+y1 && px == x+x1
        cs.push [y+y2, x+x2]
    elsif py == y+y2 && px == x+x2
        cs.push [y+y1, x+x1]
    else
        p 'bad'
    end
end

# part 1
p (cs.size-1)/2

# part 2
cs = Set.new cs
p (0...g.size).map{|y|
    inside = false
    insdir = 0
    (0...g[0].size).count{|x|
        if cs.include?([y,x])
            case g[y][x]
            when ?- then nil
            when ?| then inside = !inside
            when ?L then insdir = :top
            when ?F then insdir = :bot
            when ?J then inside = insdir == :top ? inside : !inside
            when ?7 then inside = insdir == :bot ? inside : !inside
            end
            false
        else
            inside
        end
    }
}.sum
