import Foundation

func day3() {
  guard let inputURL = Bundle.module.url(forResource: "day3", withExtension: "txt") else {
    return
  }
  guard let input = try? String(contentsOf: inputURL, encoding: .utf8).split(separator: "\n")
  else {
    return
  }

  let banks = input.map { $0.compactMap { $0.wholeNumberValue } }

  func greedyMaxes(in bank: [Int], for digits: Int) -> Int {
    var result = ""
    var remaining = bank
    for skip in stride(from: digits - 1, through: 0, by: -1) {
      let searchLength = remaining.count - skip
      let searchPortion = remaining.prefix(searchLength)
      let maxDigit = searchPortion.max()!
      let index = searchPortion.firstIndex(of: maxDigit)!
      result.append(String(remaining[index]))
      remaining.removeFirst(index + 1)
    }
    return Int(result)!
  }

  let part1 = banks.reduce(0) { $0 + greedyMaxes(in: $1, for: 2) }
  let part2 = banks.reduce(0) { $0 + greedyMaxes(in: $1, for: 12) }
  print("Part 1: \(part1), Part 2: \(part2)")
}
