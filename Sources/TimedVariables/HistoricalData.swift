import Foundation

public struct HistoricalData<D> {
  
  public typealias ReadAccessHandler = (D, UInt64) -> D
  
  public init(_ data: D, with handler: @escaping ReadAccessHandler = { s1, _ in return s1 } ) {
    __data__.append((data,DispatchTime.now().uptimeNanoseconds))
    readHandler = handler
  }
  
  private var __data__: [(D,UInt64)] = []
  public var readHandler: ReadAccessHandler! = nil
  
  public var data: D {
    get {
      return readHandler(__data__[0].0, __data__[0].1)
    }
    set {
      __data__.append((newValue,DispatchTime.now().uptimeNanoseconds))
    }
  }
  
  subscript(index: UInt64) -> (D,UInt64) {
    return __data__[Int(index)]
  }
}
