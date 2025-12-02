import Foundation

func day2() {
  guard let inputURL = Bundle.module.url(forResource: "day2", withExtension: "txt") else {
    return
  }
  guard let input = try? String(contentsOf: inputURL, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ",")
  else {
    return
  }

  let idRanges = input.map { $0.split(separator: "-").compactMap { Int($0) } }.filter { $0.count == 2 }.flatMap { $0[0]...$0[1]}.sorted()

  let part1 = idRanges.reduce(into: 0) { invalidIDSum, currentID in
    let smallestUnit = Int(log10(CGFloat(currentID)))
    if smallestUnit % 2 == 0 {
      return
    }
    let (leftHalf, rightHalf) = currentID.quotientAndRemainder(dividingBy: Int(pow(Double(10), Double(smallestUnit/2 + 1))))
    if leftHalf == rightHalf {
      invalidIDSum += currentID
    }
  }

  let part2 = idRanges.reduce(into: 0) { invalidIDSum, currentID in
    let unit = Int(log10(CGFloat(currentID)))
    let unitsToTest = 1...max(min(unit/2 + 1, unit - 1), 1)
    for unit in unitsToTest {
      let unitValue = Int(pow(Double(10), Double(unit)))
      var pieces: [Int] = []
      var idQuotient = currentID
      var idRemainder = 0
      repeat {
        (idQuotient, idRemainder) = idQuotient.quotientAndRemainder(dividingBy: unitValue)
        pieces.append(idRemainder)
      } while idQuotient > 0

      // I got lazy.
      if pieces.count > 1 && Set(pieces).count == 1 && Int(pieces.map { String($0) }.joined()) == currentID {
          invalidIDSum += currentID
          return
      }
    }
  }

  print("Part 1: \(part1), Part 2: \(part2)")
}
