import UIKit

protocol LoginViewModelProtocol {
    var showAlert: ((_ error: String) -> ())? { get set }
    
    func login(login: String?, password: String?)
}

final class LoginViewModel: LoginViewModelProtocol {
    var output: LoginOuput?
    var showAlert: ((_ error: String) -> ())?
    
    func login(login: String?, password: String?) {
        guard let login = login, !login.isEmpty, let password = password, !password.isEmpty else {
            showAlert?("Оба поля должны быть заполнены")
            return
        }
        
        AuthManager.shared.signIn(login: login, password: password) { result in
            switch result {
            case .success(let profileModel): output?.goToProfile(viewModel: profileModel)
            case .failure(let error): showAlert?(error.localizedDescription)
            }
        }
    }
}
