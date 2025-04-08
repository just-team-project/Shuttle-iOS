final class UserViewModelFactory: Sendable {
    let userLogoutUseCase: UserLogoutUseCase
    let busStationUseCase: BusStationUseCase
    
    init(userLogoutUseCase: UserLogoutUseCase, busStationUseCase: BusStationUseCase) {
        self.userLogoutUseCase = userLogoutUseCase
        self.busStationUseCase = busStationUseCase
    }
    
    @MainActor
    func create() -> UserViewModel {
        return UserViewModel(userLogoutUseCase: userLogoutUseCase, busStationUseCase: busStationUseCase)
    }
}

