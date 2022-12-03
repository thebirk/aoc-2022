# frozen_string_literal: true
require 'set'

# @param [String] input
def part1(input)
  rucksacks = input.split("\n").map { |x| [x[0..x.length / 2 - 1], x[x.length / 2..]] }

  # @param [Array<String>] rucksack
  # @return [String]
  def find_shared_item(rucksack)
    sets = rucksack.map { |x| Set.new(x.each_char) }
    return sets.inject(:&).first
  end

  sum_priority = 0
  rucksacks.each do |rucksack|
    shared = find_shared_item(rucksack).ord

    priority = 0
    if shared >= "a".ord && shared <= "z".ord
      priority = shared - "a".ord + 1
    elsif shared >= "A".ord && shared <= "Z".ord
      priority = shared - "A".ord + 26 + 1
    end

    sum_priority += priority
  end

  puts "The sum of the priorities of items types in both compartments is %s" % [sum_priority]
end

# @param [String] input
def part2(input)
  # @type [Array<string>]
  groups = input.split("\n").each_slice(3).to_a

  # @param [Array<string>] group
  def find_shared_badge(group)
    sets = group.map { |rucksack| Set.new(rucksack.each_char) }
    return sets.inject(:&).first
  end

  sum_priority = 0
  groups.each do |group|
    badge = find_shared_badge(group).ord

    priority = 0
    if badge >= "a".ord && badge <= "z".ord
      priority = badge - "a".ord + 1
    elsif badge >= "A".ord && badge <= "Z".ord
      priority = badge - "A".ord + 26 + 1
    end

    sum_priority += priority
  end

  puts "The sum of priorities of all badges is %d" % [sum_priority]
end

input = File.open("../input03.txt", "rb").read

part1(input)
part2(input)
