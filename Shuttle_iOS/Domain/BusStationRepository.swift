import UIKit

protocol BusStationRepository: Sendable {
    func readBusStations(name busName: String) -> [BusStation]
}
