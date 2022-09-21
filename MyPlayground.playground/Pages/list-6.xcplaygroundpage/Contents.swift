import Combine

let publisher0 = PassthroughSubject<Int, Never>()

final class ViewModel {
    let publisher: Publishers.Map<Publishers.Filter<PassthroughSubject<Int,Never>>, Int>
    
    init() {
        publisher = publisher0
            .filter {$0 > 0}
            .map {$0 * 2}
    }
}
