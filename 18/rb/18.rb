#!/usr/bin/env ruby

def go data
    x,y = 0,0
    px,py = 0,0
    extra = 0
    (data.map{|a,b|
        dx,dy = {'R'=>[1,0], 'L'=>[-1,0], 'D'=>[0,1], 'U'=>[0,-1]}[a]
        px=x
        py=y
        x+=dx*b
        y+=dy*b
        extra += b
        x*py - px*y
    }.sum.abs + extra) / 2 + 1
end

lines = File.readlines 'input'

# part 1
p go lines.map{|line|
    a,b,_ = line.split
    [a, b.to_i]
}

# part 2
p go lines.map{|line|
    c = line.split[-1]
    [c[-2].tr('0-3', 'RDLU'), c[2...-2].to_i(16)]
}
