# frozen_string_literal: true

# @param [Integer] you
# @param [Integer] opponent
# @return [Boolean, nil]
def win_hand?(you, opponent)
  rules = [
    [nil, false, true],
    [true, nil, false],
    [false, true, nil]
  ]

  return rules[you][opponent]
end

# @param [String] input
def part1(input)
  hand_map = {
    "A" => 1,
    "B" => 2,
    "C" => 3,

    "X" => 1,
    "Y" => 2,
    "Z" => 3
  }

  plays = input.split("\n").map { |x| x.split(" ") }
  score = 0
  plays.each do |play|
    my_hand = hand_map[play[1]]
    opponent_hand = hand_map[play[0]]
    case win_hand?(my_hand-1, opponent_hand-1)
    when true
      score += my_hand + 6
    when false
      score += my_hand
    when nil
      score += my_hand + 3
    end
  end

  puts "part1: The total score is %d" % [score]
end

# @param [String] input
def part2(input)
  plays = input.split("\n").map { |x| x.split(" ") }

  win_table = {
    "A" => "B",
    "B" => "C",
    "C" => "A"
  }
  loss_table = {
    "A" => "C",
    "B" => "A",
    "C" => "B"
  }

  score_map = {
    "A" => 1,
    "B" => 2,
    "C" => 3
  }

  score = 0
  plays.each do |play|
    case play[1]
    when "Z"
      score += score_map[win_table[play[0]]] + 6
    when "X"
      score += score_map[loss_table[play[0]]]
    when "Y"
      score += score_map[play[0]] + 3
    end
  end

  puts "part2: The total score is %d" % [score]
end

input = File.open("../input02.txt", "rb").read

part1(input)
part2(input)