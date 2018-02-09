import XCTest
import SigmaSwiftStatistics
@testable import TimedVariables

final class TimedVariablesTests: XCTestCase {
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.

		var startTime: UInt64

		var gyroscope = TimeBoundedVariable<UInt64>(0)

		var diffs: [Double] = []
		startTime = DispatchTime.now().uptimeNanoseconds
		for _ in 1...1000000 {
			gyroscope.data = DispatchTime.now().uptimeNanoseconds
			diffs.append(Double(gyroscope.timeStamp - gyroscope.data))
		}

		// let avg: Double = Sigma.average(diffs)!
		// let med: Double = Sigma.median(diffs)!
		// let std: Double = Sigma.standardDeviationPopulation(diffs)!
		print("Time It Took \(DispatchTime.now().uptimeNanoseconds - startTime)")
		for d in diffs {
		   print(d)
		}

		// print("Average: \(avg) Median: \(med) Std: \(std)\n")

		// XCTAssertTrue(std <= 4*med)
	}


	static var allTests = [
		("testExample", testExample),
	]
}
