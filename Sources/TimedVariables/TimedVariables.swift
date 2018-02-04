import Foundation

extension String: Error {}

protocol Time_stamping{
    var time_stamp:UInt64 {get}
    mutating func update_timestamp()
}

protocol Time_bounded{
    var time_stamp:UInt64 {get}
    var upper_limit:Double {set get}
    var lower_limit:Double {set get}
    mutating func update_timestamp()
    func check_bound()
    func lower_exception() throws
    func upper_exception() throws

}

struct Timeline1: Time_stamping{
    var data: UInt64{
        didSet{
            update_timestamp()
        }
    }
    var time_stamp: UInt64
    mutating func update_timestamp() {
        time_stamp = DispatchTime.now().uptimeNanoseconds

    }
}

struct Timeline2: Time_bounded{

    init(data: UInt64, lower: Double, upper: Double) {
        __data__ = data
        lower_limit = lower
        upper_limit = upper
        time_stamp = DispatchTime.now().uptimeNanoseconds
    }

    mutating func update_timestamp() {
        time_stamp = DispatchTime.now().uptimeNanoseconds
    }

    func lower_exception() throws {
        throw "Too Young"
    }

    private var __data__: UInt64

    var data: UInt64 {
        get {
            check_bound()
            return __data__
        }
        set {
            update_timestamp()
            __data__ = newValue
        }
    }

    var time_stamp: UInt64
    var lower_limit: Double
    var upper_limit: Double

    func upper_exception() throws {
        throw "Too Old"
    }

    func check_bound() {
        let temp = DispatchTime.now().uptimeNanoseconds - time_stamp
        if temp > UInt64(upper_limit * 1e9){
            do {
                try upper_exception()
            } catch let error{
                Swift.print ("Error: \(error)")
            }
        }
        else if temp < UInt64(lower_limit * 1e9){
            do {
                try lower_exception()
            } catch let error{
                Swift.print ("Error: \(error)")
            }
        }
    }
}

