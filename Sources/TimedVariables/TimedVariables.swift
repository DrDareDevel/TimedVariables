import Foundation

extension String: Error {}

public protocol TimeStamp{
    var data: UInt64 {get set}
    var timeStamp:UInt64 {get}
    mutating func updateTimeStamp()
}

public protocol TimeBound: TimeStamp{
    var upperLimit:Double {set get}
    var lowerLimit:Double {set get}
    func checkBound()
    func lowerException() throws
    func upperException() throws
}

public struct TimeStampedVariable: TimeStamp{
    public var data: UInt64 {
        didSet{
            updateTimeStamp()
        }
    }
    public private(set) var timeStamp: UInt64
    public mutating func updateTimeStamp(){
        timeStamp = DispatchTime.now().uptimeNanoseconds
    }
}

public struct TimeBoundedVariable: TimeBound{

    public init(data: UInt64, lower: Double, upper: Double) {
        __data__ = data
        lowerLimit = lower
        upperLimit = upper
        timeStamp = DispatchTime.now().uptimeNanoseconds
    }

    private var __data__: UInt64

    public private(set) var timeStamp: UInt64

    public var lowerLimit: Double
    public var upperLimit: Double

    public var data: UInt64 {
        get {
            checkBound()
            return __data__
        }
        set {
            updateTimeStamp()
            __data__ = newValue
        }
    }

    public mutating func updateTimeStamp() {
        timeStamp = DispatchTime.now().uptimeNanoseconds
    }

    public func lowerException() throws {
        throw "Too Young"
    }


    public func upperException() throws {
        throw "Too Old"
    }

    public func checkBound(){
        let temp = DispatchTime.now().uptimeNanoseconds - timeStamp
        if temp > UInt64(upperLimit * 1e9){
          do {
              try upperException()
          } catch let error {
              print("Error: \(error)")
          }

        }
        else if temp < UInt64(lowerLimit * 1e9){
          do {
              try lowerException()
          } catch let error {
              print("Error: \(error)")
          }
        }
    }
}
