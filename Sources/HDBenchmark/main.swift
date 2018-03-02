import Foundation
import SigmaSwiftStatistics
import TimedVariables

let NUM_OF_ITERATIONS = 1000000
var gyroscope = HistoricalData<UInt64>(0)
var diffs: [Double] = [Double](repeating: 0.0, count: NUM_OF_ITERATIONS)
let startTime: UInt64 = DispatchTime.now().uptimeNanoseconds

for i in 0..<NUM_OF_ITERATIONS {
  gyroscope.data = UInt64(i) //DispatchTime.now().uptimeNanoseconds
  //diffs[i] = (Double(gyroscope.timeStamp - gyroscope.data))
}

// let avg: Double = Sigma.average(diffs)!
// let med: Double = Sigma.median(diffs)!
// let std: Double = Sigma.standardDeviationPopulation(diffs)!
print("Time It Took \(DispatchTime.now().uptimeNanoseconds - startTime)")
// for d in diffs {
//    print(d)
// }

// print("Average: \(avg) Median: \(med) Std: \(std)\n")

print("Value 0 nanoseconds ago: \(gyroscope[0])")
print("Value 40000000 seconds ago: \(gyroscope[40000000])")
