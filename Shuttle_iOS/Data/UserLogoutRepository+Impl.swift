//
//  UserLogoutRepository+Impl.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 4/7/25.
//

final class UserLogoutRepositoryImpl: UserLogoutRepository {
    func executeLogout(uuidString: String) {
        UserDefaults.standard.removeObject(forKey: uuidString)
    }
}
