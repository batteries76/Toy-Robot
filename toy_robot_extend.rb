require 'pry'

class Toy_robot
  attr_accessor :directions, :placed, :xcoord, :ycoord, :dir_index, :board_size
  def initialize
    @xcoord = 0
    @ycoord = 0
    @placed = 0
    @directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
    @dir_index = 0
    @board_size = 5
  end
end

def print_start_options
  puts "Welcome to the toy robot."
  puts "The robot is yet to be placed. Please place the robot on the table"
  puts "Format: PLACE X,Y, DIRECTION"
  puts "(where 'PLACE' is the command, 0,0 represents the SOUTH-WEST corner, and directions can be 'N', 'S', 'E', and 'W')"
end

def print_all_options # change to give the possibilities
  if (@robot.placed == 0)
    puts "The robot is yet to be placed. Please place the robot on the table"
    puts "Format: PLACE X,Y, DIRECTION"
    puts "(where 'PLACE' is the command, 0,0 represents the SOUTH-WEST corner, and directions can be 'N', 'S', 'E', and 'W')"
  else
    puts "You have the following options: MOVE, LEFT, RIGHT, REPORT"
  end
  evaluate_input
end

def print_place_options
  puts "PLACE must be followed by two numbers and a direction."
  puts "Format: PLACE X,Y, DIRECTION"
  puts "(where 'PLACE' is the command, 0,0 represents the SOUTH-WEST corner, and directions can be 'N', 'S', 'E', and 'W')"
  evaluate_input
end

def print_invalid_move
  puts "Your robot will fall off the table!"
  puts "I suggest changing direction.."
  evaluate_input
end

def main
  @robot = Toy_robot.new
  print_start_options
  evaluate_input
end

def evaluate_input
  puts ""
  print "Please enter your command: "
  input = gets.chomp
  puts ""
  input_arr = input.split(' ')
  if input_arr[0].upcase == 'PLACE'
    options_arr = input_arr[1].split(',')
    place_option(options_arr)
  elsif input_arr[0].upcase == 'QUIT'
    quit_option
  elsif @robot.placed == 0
    puts "I suggest you place your robot on the table"
    print_place_options
  elsif input_arr[0].upcase == 'MOVE'
    move_option
  elsif input_arr[0].upcase == 'RIGHT' || input.upcase == 'LEFT'
    turn_option(input)
  elsif input_arr[0].upcase == 'REPORT'
    report_option
  else
    print_all_options
  end
end

def place_option(options)
  if options.length < 3
    puts "not enough options for a place command!"
    print_place_options
  end
  if ((0..@robot.board_size).member?(options[0].to_i)) == false
    puts "Error: place values must be between 0 and 4"
    print_place_options
  end
  if ((0..@robot.board_size).member?(options[1].to_i)) == false
    puts "Error: place values must be between 0 and 4"
    print_place_options
  end
  if (['N', 'S', 'E', 'W'].include?(options[2].upcase) != true)
    print_place_options
  end
  @robot.placed = 1
  @robot.xcoord = options[0].to_i
  @robot.ycoord = options[1].to_i
  @robot.direction = options[2]
  puts "Your robot has been placed at #{@robot.xcoord},#{@robot.ycoord} and is facing #{@robot.direction.upcase}"
  evaluate_input
end

def move_option
  direction = @robot.direction.upcase
  if direction == 'N'
    if @robot.ycoord == @robot.board_size
      print_invalid_move
    else
      @robot.ycoord = @robot.ycoord + 1
    end
  elsif direction == 'S'
    if @robot.ycoord == 0
      print_invalid_move
    else
      @robot.ycoord = @robot.ycoord - 1
    end
  elsif direction == 'E'
    if @robot.xcoord == @robot.board_size
      print_invalid_move
    else
      @robot.xcoord = @robot.xcoord + 1
    end
  elsif direction == 'W'
    if @robot.xcoord == 0
      print_invalid_move
    else
      @robot.xcoord = @robot.xcoord - 1
    end
  end
  puts "Your robot has moved to #{@robot.xcoord},#{@robot.ycoord} and is facing #{@robot.direction.upcase}"
  evaluate_input
end

def turn_option(turn) #extend to use the index
  direction = @robot.direction.upcase
  if turn.upcase == 'RIGHT'
    if direction == 'N'
      @robot.direction = 'E'
    elsif direction == 'E'
      @robot.direction = 'S'
    elsif direction == 'S'
      @robot.direction = 'W'
    elsif direction == 'W'
      @robot.direction = 'N'
    end
  elsif turn.upcase == 'LEFT'
    if direction == 'N'
      @robot.direction = 'W'
    elsif direction == 'W'
      @robot.direction = 'S'
    elsif direction == 'S'
      @robot.direction = 'E'
    elsif direction == 'E'
      @robot.direction = 'N'
    end
  end
  puts "Your robot has turned #{@robot.direction.upcase}, and is at #{@robot.xcoord},#{@robot.ycoord}"
  evaluate_input
end

def report_option
  puts "Your robot is currently at #{@robot.xcoord},#{@robot.ycoord} and is facing #{@robot.direction.upcase}"
  evaluate_input
end

def quit_option
  puts "Quitting!"
  puts ""
  exit
end

main
