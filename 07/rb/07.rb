#!/usr/bin/env ruby

def judge cards
    cnt = cards.map{|c|cards.count c}.sort
    maxcnt = cnt[-1]
    return 9 if maxcnt == 5
    return 8 if maxcnt == 4
    return 7 if cnt == [2,2,3,3,3]
    return 6 if maxcnt == 3
    return 5 if cnt == [1,2,2,2,2]
    return 4 if maxcnt == 2
    return 3
end

[['23456789TJQKA', [0]], ['J23456789TQKA', (1..12)]].each do |val, zeroes|
    hands = File.readlines('input').map{|x|
        cards, bid = x.split
        cards = cards.chars.map{|c| val.index c}
        kind = zeroes.map{|j| judge cards.map{|c|c==0 ? j : c}}.max
        [[kind, *cards], bid.to_i]
    }.sort
    p hands.map.with_index{|x,i| x[-1]*(i+1)}.sum
end
