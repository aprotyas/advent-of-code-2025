import Foundation

func day5() {
  guard let inputURL = Bundle.module.url(forResource: "day5", withExtension: "txt") else {
    return
  }
  guard
    let input = try? String(contentsOf: inputURL, encoding: .utf8).split(
      separator: "\n", omittingEmptySubsequences: false)
  else {
    return
  }
  guard let separatorIndex = input.firstIndex(of: "") else {
    return
  }
  let (ranges, ingredients) = (
    input[..<separatorIndex].compactMap { $0.split(separator: "-").compactMap { Int($0) } },
    input[(separatorIndex + 1)...].compactMap { Int($0) }
  )

  let part1 = ingredients.reduce(into: 0) { freshCount, ingredient in
    var fresh: Bool = false
    for range in ranges {
      guard let start = range.first else {
        continue
      }
      guard let end = range.last else {
        continue
      }
      if ingredient >= start && ingredient <= end {
        fresh = true
        break
      }
    }
    if fresh {
      freshCount += 1
    }
  }

  var part2 = 0
  var sortedRanges = ranges.sorted { $0.first! < $1.first! }
  repeat {
    var skip = 0
    var firstRange = sortedRanges.removeFirst()
    for range in sortedRanges {
      if range.first! <= firstRange.last! {
        firstRange[1] = max(firstRange.last!, range.last!)
        skip += 1
      } else {
        break
      }
    }
    sortedRanges.removeFirst(skip)
    part2 += firstRange.last! - firstRange.first! + 1
  } while !sortedRanges.isEmpty

  print("Part 1: \(part1), Part 2: \(part2)")
}
