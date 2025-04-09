import Foundation

protocol UserLoginRepository: Sendable {
    func existLocalData(email: String, uuid: String) -> Bool
    func existServerData(email: String, uuid: String) throws -> Bool
    func sendData(email: String, uuid: String) throws
}
