# frozen_string_literal: true

class AocFile
  # @return [String]
  attr_accessor :name
  # @return [Integer]
  attr_accessor :size

  # @param [String] name
  # @param [Integer] size
  def initialize(name, size)
    @name = name
    @size = size
  end
end

# @param [String] input
# @return [Hash<String, Array<AocFile>>]
def parse_input(input)
  lines = input.lines(chomp: true)
  state = :start

  current_dir = ""
  dirs = Hash.new { |h, k| h[k] = [] }

  lines.each do |line|
    case state
    when :start
      case line
      when /\$ cd ([\/A-Za-z0-9\.]+)/
        dir = $1

        if dir.start_with?("/")
          current_dir = dir
        elsif dir == ".."
          current_dir = current_dir.slice(0, current_dir.rindex("/"))
          if current_dir == ""
            current_dir = "/"
          end
        else
          if current_dir == "/"
            current_dir += dir
          else
            current_dir += "/" + dir
          end
        end

        next
      when "$ ls"
        state = :list
        next
      end
    when :list
      if line.start_with?("$")
        state = :start
        redo
      end

      case line
      when /dir ([\/A-Za-z0-9\.]+)/
        dir = $1
        dirs[current_dir].push(AocFile.new(dir, -1))
      when /([0-9]+) ([A-Za-z0-9\.]+)/
        size = $1.to_i
        name = $2
        dirs[current_dir].push(AocFile.new(name, size))
      end
    end
  end

  return dirs
end

# @param [String] input
def part1_2(input)
  dirs = parse_input(input)
  sizes = {}

  # @param [Hash<String, Integer>] sizes
  # @param [Hash<String, Array<AocFile>>] dirs
  # @param [String] dirname
  def eval_size(sizes, dirs, dirname)
    if sizes.has_key?(dirname)
      return sizes[dirname]
    end

    size = 0
    dir = dirs[dirname]
    dir.each do |file|
      if file.size > 0
        size += file.size
      else
        if dirname == "/"
          size += eval_size(sizes, dirs, dirname + file.name)
        else
          size += eval_size(sizes, dirs, dirname + "/" + file.name)
        end
      end
    end

    sizes[dirname] = size

    return size
  end

  eval_size(sizes, dirs, "/")

  puts "The sum total size of directories with a size at most 100 000 is %d" % [sizes.values.filter {|v| v <= 100000}.sum]

  total_space = 70000000
  required_space = 30000000
  current_space = total_space - sizes["/"]
  missing_space = required_space - current_space
  minimal_deletion = sizes.values.filter {|v| v >= missing_space}.min
  puts "The size of the smallest directory that would free up enough space to run the update is %d" % [minimal_deletion]
end

input = File.read("../input07.txt")
example_code = %{$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
}

part1_2(input)