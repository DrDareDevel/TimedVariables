import Foundation

public struct AutoTimeStampedData<D> {
    public var data: D {
        didSet{
          timeStamp = DispatchTime.now().uptimeNanoseconds
        }
    }
    public private(set) var timeStamp: UInt64
}
