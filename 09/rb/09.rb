#!/usr/bin/env ruby

def fw a
    diffs = a.each_cons(2).map{|x,y|y-x}
    diffs.all?{|d| d==0} ? a[-1] + (a[-1]-a[-2]) : a[-1] + (fw diffs)
end

def bw a
    diffs = a.each_cons(2).map{|x,y|y-x}
    diffs.all?{|d| d==0} ? a[0] - (a[1]-a[0]) : a[0] - (bw diffs)
end

# both parts
puts File.readlines('input').map{|line|
    line = line.split.map &:to_i
    [fw(line), bw(line)]
}.transpose.map &:sum
