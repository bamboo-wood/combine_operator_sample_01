import Combine
import PlaygroundSupport
import UIKit

let subject = PassthroughSubject<String, Never>()

final class ViewModel {
    let labelText: AnyPublisher<String?, Never>
    
    init() {
        labelText = subject
            .map { "[[ " + $0 + "!" + " ]]" }
            .eraseToAnyPublisher()
    }
}

final class ViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ViewModel()
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        label.frame = CGRect(x: 20, y: 20, width: 200, height: 20)
        view.addSubview(label)
        viewModel.labelText
            .assign(to: \.text, on: label)
            .store(in: &subscriptions)
    }
}

let viewController = ViewController()
viewController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 160)
PlaygroundPage.current.liveView = viewController

subject.send("a")
