import Combine

let publisher0 = PassthroughSubject<Int, Never>()

let publisher1 = publisher0
    .filter {$0 > 0}
    .map {$0 * 2}

print(type(of: publisher1))
