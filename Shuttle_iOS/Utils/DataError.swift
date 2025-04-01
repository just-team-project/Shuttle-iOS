//
//  DataError.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 4/1/25.
//

import Foundation

enum DataError: Error {
    case serverConnectFailure
    
    public var description: String {
        switch self {
        case .serverConnectFailure:
            return "서버 요청 실패! 다시 시도해주세요."
        }
    }
}
