public actor DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    private var dictionaries : [String:Any] = [:]
    
    public func register<T>(_ key: T.Type, _ value: T) {
        dictionaries[String(describing: key)] = value
    }
    
    public func resolve<T>(_ key: T.Type) throws -> T {
        let key = String(describing: key)
        guard let value = dictionaries[key] as? T else {
            throw DIError.DIContainerFailure(type: key)
        }
        return value
    }
}
