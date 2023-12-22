#!/usr/bin/env ruby

require 'set'

def onbrick brick, &blk
    sx,sy,sz,tx,ty,tz = brick
    (sx..tx).each do |x|
        (sy..ty).each do |y|
            (sz..tz).each do |z|
                blk[x, y, z]
            end
        end
    end
end

# hardcoded max dimensions, lol
sq = 10
h = 400

data = Array.new(h) { Array.new(sq) { [nil]*sq } }
byz = Hash.new {|h,v| h[v] = [] }

bricks = File.readlines('input').map.with_index do |line,idx|
    brick = line.scan(/\d+/).map &:to_i
    onbrick brick do |x,y,z| data[z][y][x] = idx; end
    byz[[brick[2], brick[5]].min].push idx
    brick
end

deps = {}
revdeps = Hash.new {|h,v| h[v] = Set.new }

(1...h).each do |chkz|
    byz[chkz].each do |idx|
        brick = bricks[idx]
        oldbrick = brick.dup
        loop {
            brick[2] -= 1
            brick[5] -= 1
            break if brick[2]<0 || brick[5]<0
            supporters = Set.new
            onbrick brick do |x,y,z|
                supporters.add data[z][y][x] if data[z][y][x] && data[z][y][x] != idx
            end
            if !supporters.empty?
                deps[idx] = supporters
                supporters.each do |s| revdeps[s].add idx; end
                break
            end
        }
        brick[2] += 1
        brick[5] += 1
        if brick != oldbrick
            onbrick oldbrick do |x,y,z| data[z][y][x] = nil; end
            onbrick brick do |x,y,z| data[z][y][x] = idx; end
        end
    end
end

# part 1
p bricks.size - deps.values.flat_map{|dep| dep.size == 1 ? dep.to_a : [] }.uniq.size

# part 2
p (0...bricks.size).map {|idx|
    fallen = Set.new [idx]
    tocheck = revdeps[idx].dup
    until tocheck.empty?
        tocheck.delete(check = tocheck.first)
        if deps[check] && deps[check].all?{|dep| fallen.include? dep }
            fallen.add check
            tocheck.merge revdeps[check].reject{|dep| fallen.include? dep }
        end
    end
    fallen.size - 1
}.sum
