//
//  DIError.swift
//  Shuttle_iOS
//
//  Created by 강대훈 on 4/1/25.
//

public enum DIError : Error {
    case DIContainerFailure(type: String)
    
    public var description: String {
        switch self {
        case .DIContainerFailure(let typeString):
            return "DIContainer Resolve Failed : \(typeString)"
        }
    }
}
