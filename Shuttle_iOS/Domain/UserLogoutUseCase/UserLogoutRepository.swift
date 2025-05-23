//
//  UserLogoutRepository.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 4/7/25.
//

protocol UserLogoutRepository: Sendable {
    func executeLogout(uuidString: String)
}
