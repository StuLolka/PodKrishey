import Foundation

enum LoginError: Error {
    case invalidUser
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUser:
            return NSLocalizedString("Неверный логин или пароль", comment: "LoginError")
        }
    }
}

final class AuthManager {
    private let testUser = ProfileModel(avatarName: "me",
                                        name: "Anstasiia",
                                        lastName: "No way",
                                        surname: "nennene",
                                        phone: "8 936 333 22 11",
                                        mail: "kakakeke@gmail.com")
    private var isLoggedIn = false
    static let shared = AuthManager()
    private init() {}
    
    func getIsLoggedIn() -> Bool {
        isLoggedIn
    }
    
    func signIn(login: String, password: String, handler: (Result<ProfileModel, LoginError>) -> ()) {
        if LoginInspector.shared.isLoginAndPasswordCorrect(login, password) {
            isLoggedIn = true
            handler(.success(testUser))
        } else {
            handler(.failure(.invalidUser))
        }
    }
    
    func signOut() {
        isLoggedIn = false
    }
}
