protocol UserLogoutRepository: Sendable {
    func executeLogout(uuidString: String)
}
