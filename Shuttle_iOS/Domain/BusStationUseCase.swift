import UIKit

final class BusStationUseCase: Sendable {
    private let repository: BusStationRepository
    
    init(repository: BusStationRepository) {
        self.repository = repository
    }
    
    func execute(name busName: String) throws -> [BusStation] {
        try repository.readBusStations(name: busName)
    }
}
