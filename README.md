# TIC-TAC-TOE in Assembly (asm)

## Overview
This is a simple Tic-Tac-Toe game implemented in Assembly language using the Irvine32 library. The game allows two players to play against each other, where Player 1 uses 'O' and Player 2 uses 'X'. The program displays the Tic-Tac-Toe board, allows players to input their moves, checks for a winner, and announces the result (win, draw, or invalid move).

## Code Explanation

### Game Flow
1. The board is represented by a 1D array of characters (`'1'` to `'9'`), where each number corresponds to an empty spot on the board.
2. Players take turns to input the number corresponding to their desired move.
3. After each move, the board is displayed again, and the game checks for a win or a draw.
4. The game ends when one player wins, the board is full and it’s a draw, or if the player attempts an invalid move.

### Functions
- **Main procedure (`main`)**: Controls the overall game loop, alternating turns between Player 1 and Player 2.
- **Displayboard**: Displays the current state of the Tic-Tac-Toe board.
- **Movesleft**: Checks if there are any available moves left on the board.
- **Checkforwin**: Determines if a player has won by checking all rows, columns, and diagonals for a matching sequence of 'O' or 'X'.

### Data and Messages
- The board is stored as an array with elements '1', '2', ..., '9' (representing empty spots).
- `player1Msg` and `player2Msg` prompt players to enter a move.
- The program announces the winner with messages like `player1WinMsg` and `player2WinMsg` or a draw with `drawMsg`.

### Endgame
- If Player 1 wins, a message saying "PLAYER 1 WINS" is displayed, and if Player 2 wins, "PLAYER 2 WINS" is displayed.
- If no player wins and there are no moves left, "ITS A DRAW" is displayed.

## How to Run
1. **Requirements**:
   - **Irvine32 library**: Make sure the `irvine32.inc` file is available in your project folder.
   - **MASM (Microsoft Macro Assembler)**: You will need MASM installed to assemble and run the code.

2. **Steps**:
   1. Open the `source.asm` file in your assembler.
   2. Assemble the code with MASM.
   3. Link the output file to create an executable.
   4. Run the executable, and follow the prompts to play the game.

## Usage
- Player 1 (O) and Player 2 (X) will take turns to enter a number between 1 and 9 (corresponding to a spot on the Tic-Tac-Toe grid).
- The game will continuously display the board and prompt the players for moves.
- Once the game ends (either a win or a draw), the result will be displayed.

## Conclusion
This code serves as a basic implementation of Tic-Tac-Toe in Assembly language. It demonstrates how to use loops, conditions, and basic I/O in Assembly, as well as some simple game logic.
