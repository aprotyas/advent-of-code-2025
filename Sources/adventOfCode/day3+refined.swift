/*
I asked my favorite AI model to make day3.swift fancy.
*/

import Foundation

// MARK: - Array Extensions

extension Array where Element == Int {
  /// Greedily extracts the maximum k-digit number by selecting the largest available
  /// digit at each position while ensuring enough digits remain for future selections.
  ///
  /// Algorithm: For each of k positions, find the max digit within a safe search window
  /// that leaves enough digits for the remaining positions, then consume up to that digit.
  ///
  /// - Parameter digitCount: Number of digits to extract (k)
  /// - Returns: The maximum k-digit number that can be formed
  func maximumNumber(selecting digitCount: Int) -> Int {
    var selectedDigits = ""
    var remainingPool = ArraySlice(self)

    // For each digit position we need to fill (from most to least significant)
    for digitsLeftToSelect in stride(from: digitCount, to: 0, by: -1) {
      // Calculate safe search boundary: must leave enough digits for future selections
      let searchBoundary = remainingPool.count - digitsLeftToSelect + 1

      // Find the best digit within the safe window
      guard let maxDigit = remainingPool.prefix(searchBoundary).max(),
            let selectedIndex = remainingPool.firstIndex(of: maxDigit)
      else { break }

      // Lock in this digit and advance past it
      selectedDigits.append("\(maxDigit)")
      remainingPool = remainingPool.dropFirst(selectedIndex - remainingPool.startIndex + 1)
    }

    return Int(selectedDigits) ?? 0
  }
}

// MARK: - Solution

func day3Refined() {
  guard let inputURL = Bundle.module.url(forResource: "day3", withExtension: "txt"),
        let input = try? String(contentsOf: inputURL, encoding: .utf8)
  else { return }

  let batteryBanks = input
    .split(separator: "\n")
    .map { line in line.compactMap(\.wholeNumberValue) }

  let totalJoltage = { (digits: Int) in
    batteryBanks
      .map { $0.maximumNumber(selecting: digits) }
      .reduce(0, +)
  }

  print("Part 1: \(totalJoltage(2)), Part 2: \(totalJoltage(12))")
}
