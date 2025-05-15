import 'dart:io';

void main() {
  Game game = Game();
  game.start();
}

class Game {
  //define a list representing the tic_tac board, initially filled with ' '
  final List<List<String>> _board =
      List.generate(3, (_) => List.filled(3, ' '));
  String _currentPlayer = 'X';
  int _turns = 0; //count number of moves

  void start() {
    print("Welcome to Tic-Tac-Toe!\n");

    while (true) {
      printInitialBoard();
      int move = _getValidMove();
      _placeMove(move);
      _turns++;

      if (_isWinner()) {
        printInitialBoard();
        print("Player $_currentPlayer wins!");
        break;
      } else if (_turns == 9) {
        printInitialBoard();
        print("No one wins!");
        break;
      }

      _switchPlayer();
    }
  }

  void printInitialBoard() {
    for (int i = 0; i < 3; i++) {
      //i to represent the 3 rows on the board
      String row = '';
      for (int j = 0; j < 3; j++) {
        //j for each column of the current row i
        //check if cell is empty, if yes add ' ' to row , otherwise adds the player's symbol
        row += _board[i][j].isEmpty ? ' ' : _board[i][j];
        if (j < 2) row += ' | ';
      }
      print(row);
      if (i < 2) print('--+---+--');
    }
    print('');
  }

//method to get valid input from player
  int _getValidMove() {
    while (true) {
      stdout.write("Player $_currentPlayer, enter your move (1-9): ");
      String? input = stdin.readLineSync();

      if (input == null || int.tryParse(input) == null) {
        print(" Invalid input. Please enter a number between 1 and 9.");
        continue;
      }

      int move = int.parse(input);
      if (move < 1 || move > 9) {
        print("Invalid range. Choose a number between 1 and 9.");
        continue;
      }
      // convert the move number into row and column
      int row = (move - 1) ~/ 3;
      int col = (move - 1) % 3;
      if (_board[row][col] != ' ') {
        print("Cell already occupied. Choose another.");
        continue;
      }

      return move;
    }
  }

// method to place the player's symbol on the board
  void _placeMove(int move) {
    int row = (move - 1) ~/ 3;
    int col = (move - 1) % 3;
    _board[row][col] = _currentPlayer;
  }

  void _switchPlayer() {
    _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
  }

  bool _isWinner() {
    // Rows and columns
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _currentPlayer &&
          _board[i][1] == _currentPlayer &&
          _board[i][2] == _currentPlayer) return true;

      if (_board[0][i] == _currentPlayer &&
          _board[1][i] == _currentPlayer &&
          _board[2][i] == _currentPlayer) return true;
    }

    // Diagonals
    if (_board[0][0] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][2] == _currentPlayer) return true;

    if (_board[0][2] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][0] == _currentPlayer) return true;

    return false;
  }
}
