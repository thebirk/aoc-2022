# frozen_string_literal: true

# @param [String] input
def part1(input)
  field = input.lines(chomp: true)

  def is_visible?(field, x, y)
    if x == 0 || x == field[0].length - 1 || y == 0 || y == field.length - 1
      return true
    end

    height = field[y][x]

    left_visible = (0...x).map { |x| field[y][x] >= height }.none?
    right_visible = (x+1...field[0].length).map { |x| field[y][x] >= height}.none?

    up_visible = (0...y).map { |y| field[y][x] >= height}.none?
    down_visible = (y+1...field.length).map { |y| field[y][x] >= height}.none?

    return left_visible | right_visible | up_visible | down_visible
  end

  visible = 0
  (0...field.length).each do |y|
    (0...field[0].length).each do |x|
      visible += if is_visible?(field, x, y) then 1 else 0 end
      #print is_visible?(field, x, y) ? 1 : 0
    end
    #puts
  end

  puts "%d trees are visible from outside the grid" % [visible]
end

# @param [String] input
def part2(input)
  field = input.lines(chomp: true)

  def calc_score(field, x, y)
    height = field[y][x]

    left_score = 0
    (-x+1..0).each do |x|
      left_score += 1

      if field[y][x.abs] >= height
        break
      end
    end

    right_score = 0
    (x+1...field[0].length).each do |x|
      right_score += 1

      if field[y][x] >= height
        break
      end
    end

    up_score = 0
    (-y+1..0).each do |y|
      up_score += 1

      if field[y.abs][x] >= height
        break
      end
    end

    down_score = 0
    (y+1...field.length).each do |y|
      down_score += 1

      if field[y][x] >= height
        break
      end
    end

    return left_score * right_score * up_score * down_score
  end

  highest_score = -1
  (0...field.length).each do |y|
    (0...field[0].length).each do |x|
      score = calc_score(field, x, y)

      if score > highest_score
        highest_score = score
      end
    end
  end

  puts "The highest scenic score is %d" % [highest_score]
end

input = File.read("../input08.txt")
example_input = %{30373
25512
65332
33549
35390
}

part1(input)
part2(input)