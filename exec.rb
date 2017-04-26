$LOAD_PATH.push('~/ruby_study')
require 'active_support'
require 'active_support/core_ext'
require 'refinements'
require 'executor'
require 'kiyoshi'
require 'pascal'
require 'sierpinski'
require 'hanoi'
require 'nabeatsu'
require 'bowling'
require 'number_expectation_game'
require 'number_expectation_game2'
#require 'byebug'
#require 'pry-byebug'

Program_map  = {}
Auto_Program = %w(Kiyoshi Pascal Sierpinski Hanoi Nabeatsu )
%w(ALL Kiyoshi Pascal Sierpinski Hanoi Nabeatsu Bowling NumberExpectationGame NumberExpectationGame2).each_with_index { |klass, i| Program_map[i] = klass }

Program_map.each { |key, klass| puts "#{key}: #{klass}\n" }
print "Please input run program number: "

run_number = gets.chomp.to_i
klass = Program_map[run_number]

if klass.nil?
  p "ERROR! A program to support is not found"
  exit
end

case klass
when "Kiyoshi", "NumberExpectationGame", "NumberExpectationGame2"; print "Please input try count (default infinity): "
when "Pascal", "Sierpinski"; print "Please input print lines (default #{Object.const_get(klass).default}): "
when "Hanoi"; print "Please input height of the tower (default 5): "
when "Nabeatsu", "Bowling"; print "Please input try count (default #{Object.const_get(klass).default}): "
end

if klass == "ALL"
  Auto_Program.each { |klass| Object.const_get(klass).start nil }
else
  c = gets.chomp
  unless c =~ /\A\d*\z/
    p "ERROR! Please input Natural number"
    exit
  end

  if Object.const_get(klass).respond_to?(:limit) && c.to_i > Object.const_get(klass).limit
    p "ERROR! limit over (limit #{Object.const_get(klass).limit})"
    exit
  end

  Object.const_get(klass).start c
end
