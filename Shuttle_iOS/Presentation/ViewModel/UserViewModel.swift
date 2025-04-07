import Foundation
import Combine
import UIKit

@MainActor
final class UserViewModel {
    enum Input {
        case logoutTapped
        case faqTapped
        case alarmTapped
        case notificationTapped
    }
    
    enum Output {
        case userLogout
        case presentFAQ
        case presentAlarm
        case presentNotification
    }
    
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables: Set<AnyCancellable> = .init()
    private var userLogoutUseCase: UserLogoutUseCase
    
    init(userLogoutUseCase: UserLogoutUseCase) {
        self.userLogoutUseCase = userLogoutUseCase
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .logoutTapped:
                self?.logoutTapped()
            case .faqTapped:
                self?.faqTapped()
            case .alarmTapped:
                self?.alarmTapped()
            case .notificationTapped:
                self?.notificationTapped()
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func logoutTapped() {
        guard let uuidString = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        userLogoutUseCase.execute(uuidString: uuidString)
        output.send(.userLogout)
    }
    
    private func faqTapped() {
        output.send(.presentFAQ)
    }
    
    private func alarmTapped() {
        output.send(.presentAlarm)
    }
    
    private func notificationTapped() {
        output.send(.presentNotification)
    }
}
