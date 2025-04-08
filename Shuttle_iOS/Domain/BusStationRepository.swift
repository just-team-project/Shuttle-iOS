import UIKit

protocol BusStationRepository: Sendable {
    func readBusStations(name busName: String) throws -> [BusStation]
}
