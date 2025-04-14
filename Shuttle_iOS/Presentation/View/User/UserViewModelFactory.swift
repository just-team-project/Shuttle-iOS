final class UserViewModelFactory: Sendable {
    let userLogoutUseCase: UserLogoutUseCase
    let busStationUseCase: BusStationUseCase
    let busLocationUseCase: BusLocationUseCase
    
    init(
        userLogoutUseCase: UserLogoutUseCase,
        busStationUseCase: BusStationUseCase,
        busLocationUseCase: BusLocationUseCase
    ) {
        self.userLogoutUseCase = userLogoutUseCase
        self.busStationUseCase = busStationUseCase
        self.busLocationUseCase = busLocationUseCase
    }
    
    @MainActor
    func create() -> UserViewModel {
        return UserViewModel(
            userLogoutUseCase: userLogoutUseCase,
            busStationUseCase: busStationUseCase,
            busLocationUseCase: busLocationUseCase
        )
    }
}

