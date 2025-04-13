import Foundation

final class UserLoginRepositoryTest : UserLoginRepository {
    func existLocalData(email: String, uuid: String) -> Bool {
        (UserDefaults.standard.string(forKey: uuid) ?? "") == email
    }
    
    func existServerData(email: String, uuid: String) throws -> Bool {
        UserDefaults.standard.set(email, forKey: uuid)
        throw DataError.serverConnectFailure
    }
    
    func sendData(email: String, uuid: String) throws {
        throw DataError.serverConnectFailure
    }
}
