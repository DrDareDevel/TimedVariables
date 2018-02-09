import XCTest
import SigmaSwiftStatistics
@testable import TimedVariables

final class TimedVariablesTests: XCTestCase {
	func testExample() {
		let NUM_OF_ITERATIONS = 1000000
		var gyroscope = TimeBoundedVariable<UInt64>(0)

		var diffs: [Double] = [Double](repeating: 0.0, count: NUM_OF_ITERATIONS)

		for _ in 1...NUM_OF_ITERATIONS {
			gyroscope.data = DispatchTime.now().uptimeNanoseconds
			diffs.append(Double(gyroscope.timeStamp - gyroscope.data))
		}

	 let avg: Double = Sigma.average(diffs)!
	 let med: Double = Sigma.median(diffs)!
	 let std: Double = Sigma.standardDeviationPopulation(diffs)!

		for d in diffs {
		   print(d)
		}

		// print("Average: \(avg) Median: \(med) Std: \(std)\n")

		XCTAssertTrue(std <= 4*med)
	}


	static var allTests = [
		("testExample", testExample),
	]
}
