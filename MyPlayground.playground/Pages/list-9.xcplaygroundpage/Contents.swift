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
            .map { Int($0) }
            // アンラップと同時にnilの場合、特定の値を返却
            .replaceNil(with: 0)
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send("1")
subject.send("x")
