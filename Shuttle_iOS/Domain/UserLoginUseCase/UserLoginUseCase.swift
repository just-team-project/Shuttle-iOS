import Foundation

final class UserLoginUseCase: Sendable {
    private let userLoginRepository: UserLoginRepository
    
    init(userLoginRepository: UserLoginRepository) {
        self.userLoginRepository = userLoginRepository
    }
    
    func execute(email : String, uuid: String) throws -> Bool {
        if userLoginRepository.existLocalData(email: email, uuid: uuid) {
            return true
        }
        else if try userLoginRepository.existServerData(email: email, uuid: uuid) {
            return true
        }
        else {
            try userLoginRepository.sendData(email: email, uuid: uuid)
            return false
        }
    }
}
