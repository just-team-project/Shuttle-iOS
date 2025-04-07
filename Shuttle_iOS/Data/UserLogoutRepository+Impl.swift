import UIKit

final class UserLogoutRepositoryImpl: UserLogoutRepository {
    func executeLogout(uuidString: String) {
        UserDefaults.standard.removeObject(forKey: uuidString)
    }
}
