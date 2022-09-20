import Combine

// イベントを送信するオブジェクト <<< Publisher >>>
let subject = PassthroughSubject<String, Never>()

final class Receiver {
    private var  subscriptions = Set<AnyCancellable>()
    
    init() {
        subject
            // .sinkで <<<subscribe>>>
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}

// イベントを受信するオブジェクト
let receiver = Receiver()

subject.send("a")
subject.send("b")
subject.send("c")
