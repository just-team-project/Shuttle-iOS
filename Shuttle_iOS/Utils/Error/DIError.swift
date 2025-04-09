public enum DIError : Error {
    case DIContainerFailure(type: String)
    
    public var description: String {
        switch self {
        case .DIContainerFailure(let typeString):
            return "DIContainer Resolve Failed : \(typeString)"
        }
    }
}
