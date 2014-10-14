require 'debugger'
require 'yaml'
require 'colorize'


class Tile
  attr_accessor :bomb, :pos, :revealed, :flagged

  def initialize(board, pos)
    @board, pos = board, pos
    @revealed, @flagged, @bomb = false, false, false
  end

  def flagged?
    @flagged
  end

  def inspect
    return "F".colorize(:red) if flagged?
    # return "B" if @bomb == true #TODO: delete this once done testing

    if @revealed == true && neighbor_bomb_count > 0
      return neighbor_bomb_count
    elsif @revealed == true && neighbor_bomb_count == 0
      underscore = "_".colorize(:green)
      return underscore
    end

    return "*".colorize(:blue) if @revealed == false
    # "*"
  end

  def flag
    # self.flagged = !self.flagged
    self.flagged? ? self.flagged = false : self.flagged = true
  end

  def reveal
    self.revealed = true 
    # return self if flagged, return self if revealed

    if self.neighbor_bomb_count == 0
      neighbors.each do |neighbor_pos|
        @board[neighbor_pos].reveal unless @board[neighbor_pos].revealed
      end
    end
  end

  def neighbor_bomb_count
    sum = 0
    neighbors.each do |neighbor_pos|
      sum += 1 if @board[neighbor_pos].bomb == true
    end
    sum
    #neighbors.select(&:bombed?).count
  end

  def neighbors
    neighbors_array = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        next if x == 0 && y == 0
        neighbors_array << [@pos[0] + x, @pos[1] + y]
      end
    end
    
    neighbors_array.select do |(x, y)|
      x.between?(0, @board.size-1) && y.between?(0, @board.size-1)
    end
  end
end

class Board
  attr_accessor :game_board#, :total_time

  def initialize(size = 8)
    @size = size
    @game_board = Array.new(@size) { Array.new(@size) }
    start_board
  end

  #note to self - why couldn't we use @total_time??
  def leader_board(total_time)
    File.open("leader_board.txt", "a") do |f|
      f.puts(total_time)
    end
  end

  def self.run
    board = Board.new(8)
    start_time = Time.now
    board.set_bombs
    board.render

    until board.won? || board.over?
      puts "Please put 'r' or 'f' followed by the coordinates (i.e. r00)"
      user_input = gets.chomp
      if user_input == "save"
        board.save
      end
      if user_input == "load"
        board = board.load
      end

      flag_or_reveal = user_input[0]
      x, y = user_input[1].to_i, user_input[2].to_i
      if flag_or_reveal == "r"
        board.game_board[x][y].reveal
      elsif flag_or_reveal == "f"
        board.game_board[x][y].flag
        # TODO: FINISH
      end
      board.render
    end

    if board.over?
      puts "You suck"
    else
      puts "You rock"
      end_time = Time.now
      total_time = (end_time - start_time).round(2)
      p "Your time was #{total_time} seconds"
      board.leader_board(total_time)
    end
  #
  # rescue => e
  #   puts e.message
  end

  def save
    serialized_board = self.to_yaml
    File.open("saved_progress.txt", "w") do |f|
      f.puts serialized_board
    end
  end

  def load
    # contents = File.read("saved_progress.txt")
    contents = YAML.load_file("saved_progress.txt")
  end


  def over?
    tiles.any? { |t| t.revealed && t.bomb }
  end

  def loss
    abort("You suck!!!! You LOSE")
    # TODO: Doesn't break out of loop
  end

  def tiles
    @game_board.flatten
  end

  def won?
    @game_board.flatten.each do |tile|
      unless tile.flagged == tile.bomb
        return false
      end
    end
    true
  end

  def start_board
    @game_board.each_index do |y|
      @game_board[y].each_index do |x|
        @game_board[x][y] = Tile.new(self, [x, y])
      end
    end
  end

  def set_bombs
    bomb_arr = @game_board.flatten.sample(1)
    bomb_arr.each do |tile|
      tile.bomb = true
    end
  end

  def size
    @game_board.size
  end

  def [](pos)
    x, y = pos#[0], pos[1]
    @game_board[x][y]
  end

  def []=(pos, mark)
    x, y = pos [0], pos[1]
    @game_board[x][y] = mark
  end

  #TODO: make it into a string and not an array with commas and stuff
  def render
    spacing = "    "
    print " "
    (0...size).each { |i| print spacing + i.to_s }
    puts ""
    (@game_board.size).times do |row|
      print "#{row}"
      (@game_board.size).times do |col|
        print "#{spacing}#{@game_board[row][col].inspect}"

      end
      puts ""
    end
    # @game_board.each do |row|
    #   p row.join("")
    # end
  end
end


Board::run
