import Foundation

@main
struct adventOfCode {
  static func main() {
    let solutions = [day1, day2, day3, day4, day5]
    for (day, solution) in solutions.enumerated() {
      print("Day \(day + 1)")
      solution()
    }
  }
}
