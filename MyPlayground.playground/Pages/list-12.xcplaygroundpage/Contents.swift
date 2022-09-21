import Combine

let subject = PassthroughSubject<String, Never>()

enum MyError: Error {
    case failToConvert
}

final class Receiver {
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        subject
            .tryMap {
                guard let value = Int($0) else {
                    throw MyError.failToConvert
                }
                return value
            }
            .retry(1)
            .sink(receiveCompletion: { completion in
                print("Completion:\n", completion)
            }, receiveValue: { value in
                print("Received value:", value)
            })
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send("1")
subject.send("2")
subject.send("x")
subject.send("1")
