import Foundation

enum DataError: Error {
    case serverConnectFailure
    case deviceRequestFailure
    
    public var description: String {
        switch self {
        case .serverConnectFailure:
            return "서버 요청 실패! 다시 시도해주세요."
        case .deviceRequestFailure:
            return "디바이스 기기 정보를 가져오지 못했습니다."
        }
    }
}
