import UIKit

final class UserLogoutRepositoryTest: UserLogoutRepository {
    func executeLogout(uuidString: String) {
        UserDefaults.standard.removeObject(forKey: uuidString)
    }
}
