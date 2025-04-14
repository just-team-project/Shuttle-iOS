protocol BusLocationRepository: Sendable {
    func readBusLocations(name busName: String) async throws -> [BusLocation]
}
