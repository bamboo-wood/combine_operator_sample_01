import Combine

let subject = PassthroughSubject<Int, Never>()

final class SomeObject {
    var value: Int = -1 {
        didSet {
            print("didSet value:", value)
        }
    }
}

final class Receiver {
    private var subscriptions = Set<AnyCancellable>()
    private let object = SomeObject()
    
    init() {
        subject
            // 条件に一致しないものは捨てる
            // .filter { $0 % 2 == 1}
        
            // 前の値と同じ値は捨てる
            // .removeDuplicates()
        
            // 条件に合致している間は捨てる、以降は捨てない
            // .drop(while: {$0 % 2 == 1})
        
            // 指定した個数だけ先頭から捨てる
            // .dropFirst(2)
        
            // 指定した個数だけ送信したら終了する
            // .prefix(2)
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send(1)
subject.send(2)
subject.send(2)
subject.send(3)
subject.send(4)
subject.send(5)
