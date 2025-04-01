//
//  UserLoginRepository.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 3/31/25.
//

import Foundation

protocol UserLoginRepository: Sendable {
    func existLocalData(email: String, uuid: String) -> Bool
    func existServerData(email: String, uuid: String) throws -> Bool
    func sendData(email: String, uuid: String) throws
}
