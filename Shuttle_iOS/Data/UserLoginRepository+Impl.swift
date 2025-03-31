//
//  UserLoginRepository+Impl.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import Foundation

final class UserLoginRepositoryImpl: UserLoginRepository {
    func existLocalData(email: String) -> Bool {
        guard let userDefaultEmail = UserDefaults.standard.string(forKey: "email") else {
            return false
        }
        return userDefaultEmail == email ? true : false
    }
    
    func existServerData(email: String) -> Bool {
        // TODO: - Server에 해당 이메일 정보가 있는지 확인.
        return true
    }
    
    func sendData(email: String) {
        // TODO: - Server에 이메일 정보, 기기정보를 보냄. (이메일 요청)
    }
}
