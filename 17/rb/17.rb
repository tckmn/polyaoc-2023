#!/usr/bin/env ruby

require 'set'

@g = File.readlines('input').map{|line| line.chomp.chars.map &:to_i }
@adj = [[1,0], [-1,0], [0,1], [0,-1]]

def go maxbad, minbad
    seen = Set.new
    b = 0
    q = {0 => [[0,0,1,0,0], [0,0,0,1,0]]}

    loop {
        if !q[b] || q[b].size == 0
            b += 1
            next
        end

        cur = q[b].shift
        next if seen.include? cur
        seen.add cur
        x,y,dx,dy,badness = cur

        return b if x == @g.size-1 && y == @g[0].size-1 && badness > minbad

        @adj.each do |xx,yy|
            nx = x+xx
            ny = y+yy
            samedir = dx == xx && dy == yy
            oppdir = dx == -xx && dy == -yy
            if nx >= 0 && nx < @g.size && ny >= 0 && ny < @g[0].size && !oppdir &&
                    (samedir ? badness < maxbad : badness > minbad)
                bb = b + @g[nx][ny]
                q[bb] = [] unless q[bb]
                q[bb].push([nx,ny,xx,yy, samedir ? badness+1 : 1])
            end
        end
    }
end

# part 1
p go 3, -1
# part 2
p go 10, 3
