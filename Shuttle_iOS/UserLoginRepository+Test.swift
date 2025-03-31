//
//  UserLoginRepository+Test.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import Foundation

final class UserLoginRepositoryTest : UserLoginRepository {
    func existLocalData(email: String) -> Bool {
        return true
    }
    
    func existServerData(email: String) -> Bool {
        return true
    }
    
    func sendData(email: String) {
        
    }
}
