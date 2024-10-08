import Foundation

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    public var signInURL: URL? { URL(string: Constants.url) }
    var isSignedIn: Bool { !accessToken.isEmpty }
    
    private var accessToken: String {
        get { UserDefaults.standard.string(forKey: "accessToken") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
    }
    
    private var refreshToken: String {
        get { UserDefaults.standard.string(forKey: "refreshToken") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "refreshToken") }
    }
    
    private var tokenExpirationDate: Date? {
        get { UserDefaults.standard.object(forKey: "tokeExpirationDate") as? Date}
        set { UserDefaults.standard.set(newValue, forKey: "tokeExpirationDate") }
    }
    
    private var shouldRefreshToken: Bool {
        guard let tokenExpirationDate else { return false }
        return Date().addingTimeInterval(300) >= tokenExpirationDate
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: Constants.tokenURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURL)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(Constants.token, forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data, error == nil else {
                completion(false)
                return }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try jsonDecoder.decode(AuthResponse.self, from: data)
                self?.cacheToken(result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool) -> Void) {
//        guard shouldRefreshToken, !refreshToken.isEmpty else {
//            completion(true)
//            return
//        }
        guard let url = URL(string: Constants.tokenURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(Constants.token, forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data, error == nil else {
                completion(false)
                return }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try jsonDecoder.decode(AuthResponse.self, from: data)
                self?.cacheToken(result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(_ result: AuthResponse) {
        accessToken = result.accessToken
        if let token = result.refreshToken {
            refreshToken = token
        }
        tokenExpirationDate = Date().addingTimeInterval(TimeInterval(result.expiresIn))
    }
}
