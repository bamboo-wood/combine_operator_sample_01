import Combine

let subject = PassthroughSubject<String, Never>()

final class SomeObject {
    var value: String = "" {
        didSet {
            print("didSet value", value)
        }
    }
}

final class Receiver {
    private var subscriptions = Set<AnyCancellable>()
    private let object = SomeObject()
    
    init() {
        subject
            // .assignは、受信した値を指定したオブジェクトのプロパティに代入します。
            // subscribeする処理は多くの場合sinkかassignのどちらかを使います。
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

// イベントを受信するオブジェクト
let receiver = Receiver()

subject.send("a")
subject.send("b")
