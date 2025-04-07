final class MainLoginViewModelFactory: Sendable {
    let userLoginUseCase: UserLoginUseCase
    
    init(userLoginUseCase: UserLoginUseCase) {
        self.userLoginUseCase = userLoginUseCase
    }
    
    @MainActor
    func create() -> MainLoginViewModel {
        return MainLoginViewModel(userLoginUseCase: userLoginUseCase)
    }
}
