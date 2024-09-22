import Foundation

extension AuthManager {
    struct Constants {
        static let clientID = "d4863882d4704bbeb70fce2f385d42f4"
        static let clientSecret = "7a10b92146e84207a92b2c2b8777c6bf"
        static let tokenURL = "https://accounts.spotify.com/api/token"
        static let redirectURL = "https://macservice.kz" // "spotify-swiftui://oauth2/callback"
        static var token: String {
            let data = "\(clientID):\(clientSecret)".data(using: .utf8)
            return "Basic \(data?.base64EncodedString() ?? "")"
        }
    }
}
