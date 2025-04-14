final class BusLocationUseCase: Sendable {
    private let repository: BusLocationRepository
    
    init(repository: BusLocationRepository) {
        self.repository = repository
    }
    
    func execute(name busName: String) async throws -> [BusLocation] {
        let busLocations = try await repository.readBusLocations(name: busName)
        return busLocations
    }
}
