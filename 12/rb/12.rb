#!/usr/bin/env ruby

$cache = {}
$nums = []
def poss template, len, numpos
    hid = [len,numpos]
    return $cache[hid] if $cache[hid]
    return 0 if $nums[numpos..-1].sum + $nums.size-1 - numpos > len

    ret = 0
    num = $nums[numpos]

    if numpos == $nums.size-1
        ret = (0..len-num).count{|i|
            !template[0...i].include?(?#) &&
            !template[i...i+num].include?(?.) &&
            !template[i+num..-1].include?(?#)
        }
    else
        if !template[0...num].include?(?.) && template[num] != ?#
            ret += poss template[num+1..-1], len-num-1, numpos+1
        end
        if template[0] != ?#
            ret += poss template[1..-1], len-1, numpos
        end
    end

    return $cache[hid] = ret
end

puts File.readlines('input').map{|line|
    template, nums = line.chomp.split
    $nums = nums.split(?,).map &:to_i

    # part 1
    $cache = {}
    p1 = poss template, template.size, 0

    # part 2
    template = ([template]*5).join '?'
    $nums = $nums*5
    $cache = {}
    p2 = poss template, template.size, 0

    [p1, p2]
}.transpose.map &:sum
