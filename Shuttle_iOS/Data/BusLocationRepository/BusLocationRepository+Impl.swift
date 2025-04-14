final class BusLocationRepositoryImpl: BusLocationRepository, Sendable {
    func readBusLocations(name busName: String) async throws -> [BusLocation] {
        // MARK: - Impl에서는 서버로부터 Get 요청을 통해서 값을 받아옴.
        return []
    }
}

