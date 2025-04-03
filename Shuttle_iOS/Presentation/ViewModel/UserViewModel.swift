//
//  UserViewModel.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 4/3/25.
//
import Foundation
import Combine

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
        // TODO: - 로그아웃 UseCase
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
