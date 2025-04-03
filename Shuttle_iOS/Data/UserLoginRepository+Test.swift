import Foundation

final class UserLoginRepositoryTest : UserLoginRepository {
    func existLocalData(email: String, uuid: String) -> Bool {
        (UserDefaults.standard.string(forKey: email) ?? "") == uuid
    }
    
    func existServerData(email: String, uuid: String) throws -> Bool {
        // TODO: - 서버에 있는지 확인하고 있으면 UserDefaults에 저장해줘야 함.
        UserDefaults.standard.set(uuid, forKey: email)
        throw DataError.serverConnectFailure
    }
    
    func sendData(email: String, uuid: String) throws {
        // TODO: - 서버에 이메일 및 기기정보 보내기.
        throw DataError.serverConnectFailure
    }
}
