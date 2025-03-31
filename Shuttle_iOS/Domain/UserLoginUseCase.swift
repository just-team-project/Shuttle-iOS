//
//  UserLoginUseCase.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import Foundation

final class UserLoginUseCase {
    private let userLoginRepository: UserLoginRepository
    
    init(userLoginRepository: UserLoginRepository) {
        self.userLoginRepository = userLoginRepository
    }
    
    func execute(email : String) -> Bool {
        // 1. UserDefault 먼저 로컬 DB 확인
        if userLoginRepository.existLocalData(email: email) {
            return true
        }
        else if userLoginRepository.existServerData(email: email) {
            return true
        }
        else {
            // TODO: - 기기정보도 같이 보내야 할 수도 있음.
            userLoginRepository.sendData(email: email)
            return false
        }
    }
}
