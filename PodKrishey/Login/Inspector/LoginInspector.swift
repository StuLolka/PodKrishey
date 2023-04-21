import Foundation

struct LoginInspector {
    private let login = "login"
    private let password = "password"
    
    static let shared = LoginInspector()
    private init() {}
    
    func isLoginAndPasswordCorrect(_ login: String, _ password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }
    
    func getTrueValuesTest() -> (String, String) {
        return (login, password)
    }
}
