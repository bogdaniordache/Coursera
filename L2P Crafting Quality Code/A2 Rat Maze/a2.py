# Do not import any modules. If you do, the tester may reject your submission.

# Constants for the contents of the maze.

# The visual representation of a wall.
WALL = '#'

# The visual representation of a hallway.
HALL = '.'

# The visual representation of a brussels sprout.
SPROUT = '@'

# Constants for the directions. Use these to make Rats move.

# The left direction.
LEFT = -1

# The right direction.
RIGHT = 1

# No change in direction.
NO_CHANGE = 0

# The up direction.
UP = -1

# The down direction.
DOWN = 1

# The letters for rat_1 and rat_2 in the maze.
RAT_1_CHAR = 'J'
RAT_2_CHAR = 'P'


class Rat:
    """ A rat caught in a maze. """
    def __init__(self, symbol, row, col):
        """docstring for __init__
            (Rat, str, int, int) -> NoneType
        """
        self.symbol = symbol
        self.row = row
        self.col = col
        self.num_sprouts_eaten = 0
    
    def set_location(self, row, col):
        """docstring for set_location
            (Rat, int, int) -> NoneType
            
            Preconditions:
                0 <= row < max row of maze
                0 <= col < max col of maze
        """
        self.row = row
        self.col = col
        
    def eat_sprout(self):
        """docstring for eat_sprout
            (Rat) -> NoneType
        """
        self.num_sprouts_eaten += 1

    def __str__(self):
        """docstring for __str__
            (Rat) -> str
        """
        return self.symbol + " at (" + str(self.row) + ", " + str(self.col) + ") ate " + str(self.num_sprouts_eaten) + " sprouts."

class Maze:
    """ A 2D maze. """

    def __init__(self, maze, rat_1, rat_2):
        """docstring for __init__
            (Maze, list of list of str, Rat, Rat) -> NoneType
        """
        self.maze = maze
        self.rat_1 = rat_1
        self.rat_2 = rat_2
        self.num_sprouts_left = self.count_sprouts()
        
    def is_wall(self, row, col):
        """docstring for is_wall
            (Maze, int, int) -> bool
        """
        return self.maze[row][col] == WALL
        
    def get_character(self, row, col):
        """docstring for get_character
            (Maze, int, int) -> str
        """
        if self.rat_1.row == row and self.rat_1.col == col:
            return self.rat_1.symbol
        if self.rat_2.row == row and self.rat_2.col == col:
            return self.rat_2.symbol
        return self.maze[row][col]
        
    def move(self, rat, row_change, col_change):
        """docstring for move
            (Maze, Rat, int, int) -> bool
        """
        next_row = rat.row + row_change
        next_col = rat.col + col_change
        if self.maze[next_row][next_col] != WALL:
            rat.row += row_change
            rat.col += col_change
            if self.maze[next_row][next_col] == SPROUT:
                rat.eat_sprout()
                self.maze[next_row][next_col] = HALL
                self.num_sprouts_left -= 1
            return True
        return False
        
    def __str__(self):
        """docstring for __str__
            (Maze) -> str
        """
        maze = ""
        for i in range(len(self.maze)):
            for j in range(len(self.maze[i])):
                maze += self.get_character(i, j)
            maze += "\n"
        maze += self.rat_1.__str__() + "\n"
        maze += self.rat_2.__str__()
        return maze
        
    def count_sprouts(self):
        """docstring for count_sprouts
            (Maze) -> int
        """
        sprouts = 0
        for row in self.maze:
            for col in row:
                if col == SPROUT:
                    sprouts += 1
        return sprouts
        
        
        
