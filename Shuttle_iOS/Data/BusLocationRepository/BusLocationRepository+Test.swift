final class BusLocationRepositoryTest: BusLocationRepository, Sendable {
    func readBusLocations(name busName: String) async throws -> [BusLocation] {
        return [
            BusLocation(name: "32사1392", lat: 11.111111, lon: -127.1231231, stationNumber: 1),
            BusLocation(name: "38호1922", lat: 11.111111, lon: -128.111111, stationNumber: 2),
        ]
    }
}

