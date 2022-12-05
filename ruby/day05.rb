# frozen_string_literal: true

# @param [String] initial
def parse_initial(initial)
  initial = initial.split("\n").reverse
  total_stacks = initial[0].split(" ").last.to_i
  stacks = Array.new(total_stacks) { |i| [] }

  initial[1..].each do |row|
    (0...total_stacks).each do |i|
      v = row[4*i + 1]
      if v != " "
        stacks[i].push(v)
      end
    end
  end

  return stacks
end

# @param [String] input
def part1(input)
  initial, instructions = input.split("\n\n")
  stacks = parse_initial(initial)
  instructions = instructions.split("\n").map { |line| line.split(/move|from|to/).map(&:strip).map(&:to_i)[1..]}

  instructions.each do |instr|
    (0...instr[0]).each do
      v = stacks[instr[1] - 1].pop
      stacks[instr[2] - 1].push(v)
    end
  end

  final = stacks.map(&:last).inject(&:+)
  puts "After the rearrangement the following crates end up on top %s" % final
end

# @param [String] input
def part2(input)
  initial, instructions = input.split("\n\n")
  stacks = parse_initial(initial)
  instructions = instructions.split("\n").map { |line| line.split(/move|from|to/).map(&:strip).map(&:to_i)[1..]}

  instructions.each do |instr|
    temp = []
    (0...instr[0]).each do
      temp.push(stacks[instr[1] - 1].pop)
    end

    temp.reverse!
    temp.each { |v| stacks[instr[2] - 1].push(v) }
  end

  final = stacks.map(&:last).inject(&:+)
  puts "After the rearrangement the following crates end up on top %s" % final
end

input = File.open("../input05.txt").read
example_input = "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"

part1(input)
part2(input)