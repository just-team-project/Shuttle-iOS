import UIKit
import Combine

@MainActor
public final class MainLoginViewModel {
    enum Input {
        case userLoginTapped(email: String)
        case busLoginTapped
    }
    
    enum Output {
        case userLoginSuccess
        case userLoginRequest
        case failure(_ errorString: String)
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
        guard let uuidString = UIDevice.current.identifierForVendor?.uuidString else {
            output.send(.failure(DataError.deviceRequestFailure.description))
            return
        }
        do {
            try userLoginUseCase.execute(email: email, uuid: uuidString)
            ? output.send(.userLoginSuccess) : output.send(.userLoginRequest)
        }
        catch let error as DataError {
            output.send(.failure(error.description))
        } catch {
            output.send(.failure("알 수 없는 에러"))
        }
    }
    
    private func busLoginTapped() {
        
    }
}
