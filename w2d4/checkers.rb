require 'debugger'
require 'colorize'

class InvalidMoveError < ArgumentError
end
class InvalidInputError < ArgumentError
end

class Piece
  attr_accessor :king, :pos, :color, :board

  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    # @board = board, @pos = pos, @color = color
    # debugger
    @king = false
  end

  def direction
    if @king == true
      return [-1, 1]
    else
      @color == :w ? [1] : [-1]
    end
  end

  def slides
    poss_slides = next_spots

    poss_slides.select! { |new_pos| @board[new_pos].nil? }

    poss_slides
  end

  def next_spots
    poss_slides = []
    curr_x = @pos[0]
    curr_y = @pos[1]
    directions = self.direction
    directions.each do |dir|
      poss_slides << [curr_x - 1, curr_y + dir] << [curr_x + 1, curr_y + dir]
    end
    poss_slides.select! { |new_pos| on_board?(new_pos) }

    poss_slides
  end

  def on_board?(position)
    position[0].between?(0, 9) && position[1].between?(0, 9)
  end

  def perform_slide(new_pos)
    return false unless self.slides.include?(new_pos)

    @board[new_pos] = self
    @board[@pos] = nil
    @pos = new_pos

    maybe_promote
    true
  end

  def jumps
   opp_color = @color == :w ? :b : :w
   near_enemies = next_spots
   poss_jumps = []   
   near_enemies.select! do |new_pos| 
    !@board[new_pos].nil? && @board[new_pos].color == opp_color 
    end #arr of enemies nearby

    near_enemies.each do |new_pos|
      dx = new_pos[0] < @pos[0] ? -2 : 2
      dy = new_pos[1] < @pos[1] ? -2 : 2
      poss_jump = [@pos[0] + dx, @pos[1] + dy ]
      poss_jumps << poss_jump if @board[poss_jump].nil?
    end
    poss_jumps
  end

  def perform_jump(new_pos)
    return false unless self.jumps.include?(new_pos)
    x_dir = new_pos[0] < @pos[0] ? -1 : 1
    y_dir = new_pos[1] < @pos[1] ? -1 : 1
    enemy_loc = [@pos[0] + x_dir, @pos[1] + y_dir]

    @board[enemy_loc] = nil
    @board[new_pos] = self
    @board[@pos] = nil
    @pos = new_pos
    maybe_promote

    true
  end

  def perform_moves!(move_sequence)
    num_moves = move_sequence.length
    # debugger
    valid = true
    if num_moves == 1
      valid = self.perform_slide(move_sequence[0])
      if !valid
        valid = self.perform_jump(move_sequence[0])
      end
      raise InvalidMoveError unless valid
    else
      num_moves.times do 
        valid = self.perform_jump(move_sequence.shift)
        raise InvalidMoveError unless valid
      end
    end

    valid
  end

  def valid_move_seq?(move_sequence)
    # move_sequence = move_sequence[0] #flatten?
    duped = @board.deep_dup
    position = self.pos
    begin
      # duped[position] = Piece.new(duped, self.pos, self.color)
      duped[position].perform_moves!(move_sequence)
    rescue InvalidMoveError
      return false
    else
      return true
    end
  end

  def maybe_promote
    end_row = @color == :w ? 9 : 0
    @king = true if @pos[1] == end_row
  end

  def perform_moves(move_sequence)

    move_sequence = move_sequence[0]
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence.dup)
    else
      raise InvalidMoveError
    end    

    true
  end

  def inspect
    "#{self.pos} #{self.color}"
  end
end






class Board

  attr_accessor :grid

  def initialize(fill_board = true)
    @grid = Array.new(10) { Array.new(10) }
    set_pieces if fill_board
  end

  #TODO: Refactor
  def set_pieces
    x_inc = 0
    4.times do |y|
      (0..8).step(2) do |x|
        x_inc = x + 1 if y.odd?
        x_inc = x if y.even?
        @grid[x_inc][y] = Piece.new(self, [x_inc, y], :w)
      end
    end

    9.downto(6) do |y|
      (0..8).step(2) do |x|
        x_inc = x if y.even?
        x_inc = x + 1 if y.odd?
        @grid[x_inc][y] = Piece.new(self, [x_inc, y], :b)
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def pieces
    @grid.flatten.compact
  end

  def pieces_of_color(color)
    pieces.select { |p| p.color == color }
  end

  def deep_dup
    duped = Board.new(false)
    pieces.each do |piece|
      duped[piece.pos] = Piece.new(duped, piece.pos, piece.color)
    end

    duped
  end

  def over?
    pieces_of_color(:w) == 0 || pieces_of_color(:b) == 0
  end
end

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(@board, :w)
    @player2 = HumanPlayer.new(@board, :b)
  end


  def play
    player = @player1
    self.render
    until @board.over?
      player_color = player.color == :w ? "White" : "Black"
      puts "It is #{player_color}'s turn"
      player.play_turn
      self.render
      player = player == @player1 ? @player2 : @player1
    end
  end

  def render
    board_border = 10
    x, y = 0, 9
    until board_border == 0
      x = 0
      print board_border == 10 ? "#{board_border} " : "#{board_border}  "
      until x > 9
        piece = @board[[x, y]]
        if piece.nil?
          print "   ".colorize(:background => colorize_grid(x, y))
        else
          # icon = [piece.class.to_s, piece.color]
          # print " #{return_icon( icon[0], icon[1] ) } ".colorize(:background => colorize_grid(x, y))
          print piece.color == :w ? " W ".colorize(:background => colorize_grid(x, y)) : " B ".colorize(:background => colorize_grid(x, y))
        end
        x += 1
      end
      print "\n"
      y -= 1
      board_border -= 1
    end
    puts "    a  b  c  d  e  f  g  h  i  j "
  end

  def colorize_grid(x, y)
    (x + y).even? ? :light_red : :light_cyan
  end
end


class HumanPlayer
  attr_accessor :color, :board
  
  def initialize(board, color)
    @board = board
    @color = color
  end
  
  def play_turn
    begin
      puts "Select your move in coordinate-form, e.g. e2, f3, g4"
      input = gets.chomp
      start_pos = parse(input)[0][0]
      move_seq = parse(input)[1]
      if @board[start_pos].nil? || @board[start_pos].color != @color
        raise InvalidInputError 
      end
      @board[start_pos].perform_moves([move_seq])
    rescue InvalidInputError
      puts "Invalid move, try again"
      retry
    rescue InvalidMoveError
      puts "Invalid move! Try again"
      retry
    end
  end

  def parse(input)
    positions = input.split(', ')
    positions.each_index do |i|
      positions[i] = convert_coords(positions[i])
    end
    raise InvalidInputError if positions.size < 2
    start_pos = positions.shift

    move_seq = positions

    return [[start_pos], move_seq]
  end

  def convert_coords(coords)
    index_arr = (:a..:j).to_a  
    x = index_arr.index(coords[0].to_sym)
    y = coords[1].to_i - 1
    [x, y]
  end
end



=begin
t = Board.new
pos = [0, 1]
t.grid[pos[0]][pos[1]]
t[pos] = :x
t.[]=(pos, :x)
=end




