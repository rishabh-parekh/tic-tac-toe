import SwiftUI

struct ContentView: View {
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State private var isXTurn: Bool = true
    @State private var gameOver: Bool = false
    @State private var winner: String = ""

    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .padding()

            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { column in
                        Button(action: {
                            if board[row][column] == "" && !gameOver {
                                board[row][column] = isXTurn ? "X" : "O"
                                isXTurn.toggle()
                                checkForWinner()
                            }
                        }) {
                            Text(board[row][column])
                                .font(.system(size: 48))
                                .frame(width: 90, height: 90, alignment: .center)
                                .foregroundColor(.green) // Set the color to dark green
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(8)
                        }
                    }
                }
            }

            if gameOver {
                Text(winner.isEmpty ? "It's a draw!" : "\(winner) wins!")
                    .font(.title)
                    .padding()
                Button("Play Again", action: resetGame)
                    .padding()
            }
        }
        .background(Color.blue)
    }

    private func checkForWinner() {
        let winningCombinations = [
            [(0, 0), (0, 1), (0, 2)],
            [(1, 0), (1, 1), (1, 2)],
            [(2, 0), (2, 1), (2, 2)],
            [(0, 0), (1, 0), (2, 0)],
            [(0, 1), (1, 1), (2, 1)],
            [(0, 2), (1, 2), (2, 2)],
            [(0, 0), (1, 1), (2, 2)],
            [(0, 2), (1, 1), (2, 0)]
        ]

        for combination in winningCombinations {
            let (a, b, c) = (combination[0], combination[1], combination[2])
            if !board[a.0][a.1].isEmpty,
               board[a.0][a.1] == board[b.0][b.1],
               board[b.0][b.1] == board[c.0][c.1] {
                gameOver = true
                winner = board[a.0][a.1]
                return
            }
        }

        if !board.flatMap({ $0 }).contains("") {
            gameOver = true
        }
    }

    private func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        isXTurn = true
        gameOver = false
        winner = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}