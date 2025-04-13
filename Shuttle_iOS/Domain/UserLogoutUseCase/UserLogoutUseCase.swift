final class UserLogoutUseCase: Sendable {
    private let userLogoutRepository: UserLogoutRepository
    
    init(userLogoutRepository: UserLogoutRepository) {
        self.userLogoutRepository = userLogoutRepository
    }
    
    func execute(uuidString: String) {
        userLogoutRepository.executeLogout(uuidString: uuidString)
    }
}
