# frozen_string_literal: true

# @param [String] input
def part1(input)
  most_calories = -1

  input.split("\n\n").each do |entry|
    sum = entry.split("\n").each.map(&:to_i).sum

    if sum > most_calories
      most_calories = sum
    end
  end

  puts "The elf with the most calories has %d calories" % [most_calories]
end

# @param [String] input
def part2(input)
  top = [-1, -1, -1]

  input.split("\n\n").each do |entry|
    sum = entry.split("\n").each.map(&:to_i).sum

    top.each_index do |idx|
      idx = top.length - idx - 1

      if sum > top[idx]
        for i in 0..idx-1
          top[i] = top[i + 1]
        end

        top[idx] = sum

        break
      end
    end
  end

  puts top
  puts "The three elves with the most calories has a combined %d calories" % [top.sum]
end


input = File.open("../input01.txt", "rb").read

part1(input)
part2("123\n\n32\n\n44\n\n176\n\n64")
#part2(input)

