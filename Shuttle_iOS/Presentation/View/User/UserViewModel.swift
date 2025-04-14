import Foundation
import Combine
import UIKit

@MainActor
final class UserViewModel {
    enum Input {
        case logoutTapped
        case faqTapped
        case alarmTapped
        case notificationTapped
        case busStationRequest(_ name: String?)
    }
    
    enum Output {
        case userLogout
        case presentFAQ
        case presentAlarm
        case presentNotification
        case busStationResponse(_ name: String)
        case busLocationResponse(_ busLocations: [BusLocation])
        case failure(_ errorString: String)
    }
    
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables: Set<AnyCancellable> = .init()
    private(set) var busStations: [BusStation] = []
    private var userLogoutUseCase: UserLogoutUseCase
    private var busStationUseCase: BusStationUseCase
    private var busLocationUseCase: BusLocationUseCase
    
    init(
        userLogoutUseCase: UserLogoutUseCase,
        busStationUseCase: BusStationUseCase,
        busLocationUseCase: BusLocationUseCase
    ) {
        self.userLogoutUseCase = userLogoutUseCase
        self.busStationUseCase = busStationUseCase
        self.busLocationUseCase = busLocationUseCase
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .logoutTapped:
                self?.logoutTapped()
            case .faqTapped:
                self?.faqTapped()
            case .alarmTapped:
                self?.alarmTapped()
            case .notificationTapped:
                self?.notificationTapped()
            case .busStationRequest(let busName):
                Task { await self?.busLocationRequest(name: busName) }
                Task { self?.busStationRequest(name: busName) }
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func logoutTapped() {
        guard let uuidString = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        userLogoutUseCase.execute(uuidString: uuidString)
        output.send(.userLogout)
    }
    
    private func faqTapped() {
        output.send(.presentFAQ)
    }
    
    private func alarmTapped() {
        output.send(.presentAlarm)
    }
    
    private func notificationTapped() {
        output.send(.presentNotification)
    }
    
    private func busStationRequest(name busName: String?) {
        guard let busName = busName else {
            output.send(.failure("알 수 없는 에러"))
            return
        }
        do {
            let busStations = try busStationUseCase.execute(name: busName)
            self.busStations = busStations
            output.send(.busStationResponse(busName))
        }
        catch let error as DataError {
            // TODO: - 에러 처리
            print(error.description)
        } catch {
            // TODO: - 에러 처리
            print(error.localizedDescription)
        }
    }
    
    private func busLocationRequest(name busName: String?) async {
        guard let busName = busName else {
            output.send(.failure("알 수 없는 에러"))
            return
        }
        do {
            let busLocations = try await busLocationUseCase.execute(name: busName)
            output.send(.busLocationResponse(busLocations))
        }
        catch let error as DataError {
            // TODO: - 에러 처리
            print(error.description)
        } catch {
            // TODO: - 에러 처리
            print(error.localizedDescription)
        }
    }
}
