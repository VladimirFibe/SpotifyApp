import Foundation

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirect = "https://macservice.kz"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirect)&show_dialog=TRUE"
        return URL(string: string)
    }
    var isSignedIn: Bool { false }
    
    private var accessToken: String? { nil }
    
    private var refreshToken: String? { nil }
    
    private var tokenExpirationDate: Date? { nil }
    
    private var shouldRefreshToken: Bool { false }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
