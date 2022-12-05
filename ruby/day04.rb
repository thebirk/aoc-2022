# frozen_string_literal: true
require 'set'

# @param [String] input
def part1(input)
  assignments = input.split("\n").map { |assignment| assignment.split(",").map { |range| range.split("-") } }

  total = 0
  assignments.each do |assignment|
    a = Set.new((assignment[0][0].to_i..assignment[0][1].to_i))
    b = Set.new((assignment[1][0].to_i..assignment[1][1].to_i))

    if a.subset?(b) || a.superset?(b)
      total += 1
    end
  end

  puts "The number of assignment pairs that fully contains the other is %d" % [total]
end

def part2(input)
  assignments = input.split("\n").map { |assignment| assignment.split(",").map { |range| range.split("-") } }

  total_overlap = 0
  assignments.each do |assignment|
    a = Set.new((assignment[0][0].to_i..assignment[0][1].to_i))
    b = Set.new((assignment[1][0].to_i..assignment[1][1].to_i))

    if a.intersect?(b)
      total_overlap += 1
    end
  end

  puts "The number of assignment pairs that overlap is %d" % [total_overlap]
end

input = File.open("../input04.txt").read
example_input = "2-4,6-8\n2-3,4-5\n5-7,7-9\n2-8,3-7\n6-6,4-6\n2-6,4-8"

part1(input)
part2(input)