# frozen_string_literal: true

# @param [String] input
def part1(input)
  packet = []
  processed = 0
  input.each_char do |char|
    if packet.size < 4
      packet.push(char)
      processed += 1
      next
    end

    if packet.uniq.length == packet.length
      break
    end

    packet.shift
    packet.push(char)
    processed += 1
  end

  puts "%d were processed before the first start-of-packet marker" % processed
end

# @param [String] input
def part2(input)
  packet = []
  processed = 0
  input.each_char do |char|
    if packet.size < 14
      packet.push(char)
      processed += 1
      next
    end

    if packet.uniq.length == packet.length
      break
    end

    packet.shift
    packet.push(char)
    processed += 1
  end

  puts "%d were processed before the first start-of-packet marker" % processed
end

input = File.read("../input06.txt")
example_input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

part1(input)
part2(input)