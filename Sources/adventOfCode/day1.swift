import Foundation

func day1() {
  guard let inputURL = Bundle.module.url(forResource: "day1", withExtension: "txt") else {
    return
  }
  guard let input = try? String(contentsOf: inputURL, encoding: .utf8).split(separator: "\n")
  else {
    return
  }

  var hitZero = 0
  var crossedZero = 0
  var dialPosition = 50

  for rotation in input {
    guard let rotationMagnitude = Int(rotation.dropFirst()) else {
      continue
    }
    let isLeft = rotation.hasPrefix("L")

    var crossingsThisRotation = 0
    if isLeft {
      if rotationMagnitude >= dialPosition && dialPosition > 0 {
        crossingsThisRotation = (rotationMagnitude - dialPosition) / 100 + 1
      } else if dialPosition == 0 {
        crossingsThisRotation = rotationMagnitude / 100
      }
      dialPosition = ((dialPosition - rotationMagnitude) % 100 + 100) % 100
    } else {
      crossingsThisRotation = (dialPosition + rotationMagnitude) / 100
      dialPosition = (dialPosition + rotationMagnitude) % 100
    }

    crossedZero += crossingsThisRotation

    if dialPosition == 0 {
      hitZero += 1
    }
  }

  print("Part 1: \(hitZero), Part 2: \(crossedZero)")
}
