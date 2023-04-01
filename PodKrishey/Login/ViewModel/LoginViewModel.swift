import UIKit

protocol LoginViewModelProtocol {
    var showAlert: (() -> ())? { get set }
    
    func checkUser(login: String?, password: String?)
}

final class LoginViewModel: LoginViewModelProtocol {
    var output: LoginOuput?
    var showAlert: (() -> ())?

    func checkUser(login: String?, password: String?) {
        guard let login = login, let password = password else {
            showAlert?()
            return
        }
        do {
            try LoginInspector.checkUser(login: login, password: password)
        } catch {
            showAlert?()
        }
        output?.goToProfile(viewModel: getUser())
    }
    
    private func getUser() -> ProfileModel {
        ProfileModel(isUserActive: true, avatarName: "me", name: "Anstasiia", lastName: "No way", surname: "nennene", phone: "8 936 333 22 11", mail: "kakakeke@gmail.com")
    }
}
