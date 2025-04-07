//
//  UserLogoutUseCase.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 4/7/25.
//

final class UserLogoutUseCase: Sendable {
    private let userLogoutRepository: UserLogoutRepository
    
    init(userLogoutRepository: UserLogoutRepository) {
        self.userLogoutRepository = userLogoutRepository
    }
    
    func execute(uuidString: String) {
        userLogoutRepository.executeLogout(uuidString: uuidString)
    }
}
