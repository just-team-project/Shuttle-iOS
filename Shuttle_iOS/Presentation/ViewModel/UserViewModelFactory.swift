final class UserViewModelFactory: Sendable {
    let userLogoutUseCase: UserLogoutUseCase
    
    init(userLogoutUseCase: UserLogoutUseCase) {
        self.userLogoutUseCase = userLogoutUseCase
    }
    
    @MainActor
    func create() -> UserViewModel {
        return UserViewModel(userLogoutUseCase: userLogoutUseCase)
    }
}

