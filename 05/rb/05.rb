#!/usr/bin/env ruby

# this didn't end up being necessary
# def merge x
#     x.sort_by! &:first
#     arr = [x.shift]
#     x.each do |a,b|
#         if a <= arr[-1][1]
#             arr[-1][1] = [b,arr[-1][1]].max
#         else
#             arr.push [a,b]
#         end
#     end
#     arr
# end

def go seed
    seed = seed.each_slice(2).map{|a,b| [a,a+b]}

    $maps.each do |m|
        newseed = []

        until seed.empty?
            l,h = seed.shift
            next if m.find {|a,b,c|
                if l <= b && b < h
                    top = [c,h].min
                    seed.push [l,b] if l<b
                    seed.push [c,h] if c<h
                    newseed.push [a, a+top-b]
                elsif l < c && c <= h
                    seed.push [c,h] if c<h
                    newseed.push [a+l-b, a+c-b]
                elsif b <= l && h <= c
                    newseed.push [a+l-b, a+h-b]
                end
            }
            newseed.push [l,h]
        end

        seed = newseed
    end

    seed.map(&:first).min
end

seed, *rest = File.read('input').split "\n\n"
seed = seed.split[1..-1].map &:to_i
$maps = rest.map{|m| m.lines[1..-1].map{|line| line.split.map &:to_i }.map{|a,b,c| [a,b,b+c]} }

# part 1
p go seed.flat_map{|x|[x,1]}

# part 2
p go seed
