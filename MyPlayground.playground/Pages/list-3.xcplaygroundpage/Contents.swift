import Combine

let subject = PassthroughSubject<String, Never>()

final class SomeObject {
    var value: String = "" {
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
            // あるPublisherを別のPublisherに変換するメソッドを、Combineの用語で「Operator」と呼びます。
            .map{ $0 + "!!" }
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send("DON")
subject.send("DONDON")

