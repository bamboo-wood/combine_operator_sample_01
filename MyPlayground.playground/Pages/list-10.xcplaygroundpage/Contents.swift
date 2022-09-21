import Combine

let subject = PassthroughSubject<String, Never>()

final class SomeObject {
    var value: Int? = -1 {
        didSet {
            print("didSet value: ", value)
        }
    }
}

final class Receiver {
    private var subscriptions = Set<AnyCancellable>()
    private let object = SomeObject()
    
    init() {
        subject
            // アンラップと同時にnilを送信しないようにする
            .compactMap { Int($0) }
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send("1")
subject.send("x")
