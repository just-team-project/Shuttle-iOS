import UIKit

final class BusStationRepositoryTest: BusStationRepository {
    func readBusStations(name busName: String) throws -> [BusStation] {
        return [
            BusStation(name: "한신대학교 (정문)", lat: 37.1933281, lon: 127.0225987),
            BusStation(name: "청명역 (경유)", lat: 37.2595832, lon: 127.0790738),
            BusStation(name: "한신대학교 (후문)", lat: 37.1933281, lon: 127.0225987),
        ]
    }
}

