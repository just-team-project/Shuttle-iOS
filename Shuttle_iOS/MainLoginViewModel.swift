//
//  MainLoginViewModel.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import Foundation
import Combine

public final class MainLoginViewModel {
    enum Input {
        case userLoginTapped(email: String)
        case busLoginTapped
    }
    
    enum Output {
        case userLoginSuccess
        case userLoginRequest
        case invalidEmail
    }
    
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables : Set<AnyCancellable> = .init()
    private var userLoginUseCase : UserLoginUseCase
    
    init(userLoginUseCase : UserLoginUseCase) {
        self.userLoginUseCase = userLoginUseCase
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .userLoginTapped(let email):
                self?.userLoginTapped(email)
            case .busLoginTapped:
                self?.busLoginTapped()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func userLoginTapped(_ email: String) {
        // 서버에 해당 이메일 유저가 존재하는지 확인 (Get)
        // true -> 바로 로그인
        // false -> 서버에 이메일, 링크 요청
        
        // 유저 정보 있는지 확인.
        if userLoginUseCase.execute(email: email) {
            output.send(.userLoginSuccess)
        }
        else {
            output.send(.userLoginRequest)
        }
    }
    
    private func busLoginTapped() {
        
    }
}
