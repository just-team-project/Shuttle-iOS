//
//  UserLoginRepository+Impl.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import Foundation

final class UserLoginRepositoryImpl: UserLoginRepository {
    func existLocalData(email: String, uuid: String) -> Bool {
        return true
    }
    
    func existServerData(email: String, uuid: String) throws -> Bool {
        return true
    }
    
    func sendData(email: String, uuid: String) throws {
        
    }
}
