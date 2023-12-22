#!/usr/bin/env ruby

words = %w[- one two three four five six seven eight nine]
lines = File.readlines 'input'

# part 1

p lines.map{|line| (line[/\d/] + line.reverse[/\d/]).to_i }.sum

# part 2

fst = lines.map{|line|
    m = line[/\d|#{words.join(?|)}/]
    words.index(m) || m.to_i
}

lst = lines.map{|line|
    m = line.reverse[/\d|#{words.join(?|).reverse}/]
    words.index(m.reverse) || m.to_i
}

p fst.zip(lst).map{|a,b| a*10+b }.sum
