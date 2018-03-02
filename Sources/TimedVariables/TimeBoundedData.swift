import Foundation

public struct TimeBoundedData<D> {

    public typealias ReadAccessHandler = (D, UInt64) -> D

    public init(_ data: D, with handler: @escaping ReadAccessHandler = { s1, _ in return s1 } ) {
      timeStamp = DispatchTime.now().uptimeNanoseconds
      __data__ = data
      readHandler = handler
    }

    private var __data__: D

    public private(set) var timeStamp: UInt64
    public var readHandler: ReadAccessHandler! = nil

    public var data: D {
        get {
            return readHandler(__data__, timeStamp)
        }
        set {
            timeStamp = DispatchTime.now().uptimeNanoseconds
            __data__ = newValue
        }
    }
  }
  
