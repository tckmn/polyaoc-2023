#!/usr/bin/env ruby

instr, _, *tbl = File.readlines 'input'
tbl = tbl.map{|x| a,*b = x.scan(/\w+/); [a,b] }.to_h

periods = {}
tbl.keys.select{|k| k[-1] == ?A }.each do |st|
    s = st
    instr.chomp.chars.cycle.with_index do |ch,i|
        s = tbl[s][ch === 'L' ? 0 : 1]
        if s[-1] == ?Z
            periods[st] = i+1
            break
        end
    end
end

# part 1
p periods['AAA']
# part 2
p periods.values.reduce :lcm
