import Foundation

enum LoginError: Error {
    case invalidUser
}

enum LoginInspector {
    private static let trueLogin = "login"
    private static let truePassword = "password"
    
    static func checkUser(login: String, password: String) throws {
        if trueLogin != login || truePassword != password {
            throw LoginError.invalidUser
        }
    }
    
    static func getTrueValuesTest() -> (String, String) {
        return (trueLogin, truePassword)
    }
}
