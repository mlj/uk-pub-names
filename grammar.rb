#!/usr/bin/env ruby
require 'set'

class Set
  def to_grammar
    if size == 1
      first
    else
      "{#{to_a.sort.join('|')}}"
    end
  end
end

binominals = {}
ye_olde_binominals = {}
possessives = {}
three_mononominals = {}
ye_olde_inne = Set.new
ye_olde = Set.new
rest = Set.new

STDIN.each_line do |l|
  l.chomp!
  name, article, _, _, _ = l.split(/\t/)

  case name
  when /^Ye Olde ([\s\w']+) (And|and|&) ([\s\w']+)$/
    first, second = $1, $3
    ye_olde_binominals[first] ||= Set.new
    ye_olde_binominals[first] << second
  when /^([\s\w']+) (And|and|&) ([\s\w']+)$/
    first, second = $1, $3
    binominals[first] ||= Set.new
    binominals[first] << second
  when /^Ye Olde Inne?$/
    np = $1
    ye_olde_inne << ''
  when /^Ye Olde ([\s\w']+) Inne?$/
    np = $1
    ye_olde_inne << np
  when /^Ye Olde ([\s\w']+)$/
    np = $1
    ye_olde << np
  when /^([\s\w]+)'s ([\s\w]+)$/
    first, second = $1, $2
    possessives[first] ||= Set.new
    possessives[first] << second
  else
    rest << name
  end
end

puts "The X AND Y"
puts "-----------"
binominals.each do |first, second_set|
  puts [first, second_set.to_grammar].join(' AND ')
end

puts
puts "Ye Olde X AND Y"
puts "---------------"
ye_olde_binominals.each do |first, second_set|
  puts "Ye Olde #{[first, second_set.to_grammar].join(' AND ')}"
end

puts
puts "Ye Olde X"
puts "---------"
puts "Ye Olde #{ye_olde.to_grammar}"
puts "Ye Olde #{ye_olde_inne.to_grammar} Inn(e)"

puts
puts "(The) X's Y"
puts "-----------"
possessives.each do |first, second_set|
  puts "#{first}'s {#{second_set.to_a.sort.join('|')}}"
end

puts
puts "Uncategorised"
puts "-------------"
rest.each do |name|
  puts name
end
