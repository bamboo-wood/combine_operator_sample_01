import Combine

let publisher0 = PassthroughSubject<Int, Never>()

let publisher1 = publisher0
    .filter { $0 > 0 }
    .map { $0 * 2}

let publisher2 = publisher1
    .eraseToAnyPublisher()

print(type(of: publisher2))
