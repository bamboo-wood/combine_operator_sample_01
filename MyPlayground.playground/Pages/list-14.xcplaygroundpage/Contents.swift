import Combine

let subjectX = PassthroughSubject<String, Never>()
let subjectY = PassthroughSubject<String, Never>()

final class SomeObject {
    var value: String = "" {
        didSet {
            print("didSet value:", value)
        }
    }
}

final class Receiver {
    private var subscriptions = Set<AnyCancellable>()
    private let object = SomeObject()
    
    init() {
        subjectX
            // 常に最新の値が必要な場合に有用
            // .combineLatest(subjectY)
        
            // それぞれに送信された値を順にペアで扱いたい時に有用
            // .zip(subjectY)
        
            // どちらか
            .merge(with: subjectY)
//            .map { valueX, valueY in
//                "X:" + valueX + ", Y:" + valueY
//            }
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
    }
}

let receiver = Receiver()

subjectX.send("1")
subjectX.send("2")
subjectY.send("c")

receiver.cancel()

subjectY.send("d")
subjectX.send("5")
