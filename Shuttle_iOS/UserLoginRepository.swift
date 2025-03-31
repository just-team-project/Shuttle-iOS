//
//  UserLoginRepository.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import Foundation

protocol UserLoginRepository {
    func existLocalData(email: String) -> Bool
    func existServerData(email: String) -> Bool
    func sendData(email: String)
}
