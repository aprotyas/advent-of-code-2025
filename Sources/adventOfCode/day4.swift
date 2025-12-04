import Foundation

func day4() {
  guard let inputURL = Bundle.module.url(forResource: "day4", withExtension: "txt") else {
    return
  }
  guard let input = try? String(contentsOf: inputURL, encoding: .utf8).split(separator: "\n")
  else {
    return
  }

  enum State {
    case empty
    case paper
    case willRemove
  }

  let grid: [[State]] = input.map { $0.map { $0 == "@" ? .paper : .empty } }

  func eliminateRolls(_ originalGrid: [[State]], exhaust: Bool) -> Int {
    var grid = originalGrid
    var rollsEliminated = 0
    var previousRollsEliminated = rollsEliminated
    repeat {
      previousRollsEliminated = rollsEliminated
      for rowIndex in 0..<grid.count {
        let rowCount = grid[rowIndex].count
        for colIndex in 0..<rowCount {
          if grid[rowIndex][colIndex] != State.paper {
            continue
          }
          let isValidIndex: (Int, Int) -> Bool = {
            $0 >= 0 && $0 < grid.count && $1 >= 0 && $1 < rowCount
          }
          let neighboringCoordinatesToCheck: (Int, Int) -> [(Int, Int)] = { rowIndex, colIndex in
            var neighbors: [(Int, Int)] = []
            for r in rowIndex - 1...rowIndex + 1 {
              for c in colIndex - 1...colIndex + 1 {
                neighbors.append((r, c))
              }
            }
            return neighbors.filter(isValidIndex).filter { $0 != rowIndex || $1 != colIndex }
          }
          if neighboringCoordinatesToCheck(rowIndex, colIndex).count(where: {
            grid[$0][$1] != State.empty
          }) < 4 {
            rollsEliminated += 1
            grid[rowIndex][colIndex] = .willRemove
          }
        }
      }
      grid = grid.map { $0.map { $0 == .willRemove ? .empty : $0 } }
    } while exhaust && rollsEliminated > previousRollsEliminated
    return rollsEliminated
  }

  let part1 = eliminateRolls(grid, exhaust: false)
  let part2 = eliminateRolls(grid, exhaust: true)
  print("Part 1: \(part1), Part 2: \(part2)")
}
