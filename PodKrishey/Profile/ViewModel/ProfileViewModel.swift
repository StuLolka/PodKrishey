import UIKit

protocol ProfileViewModelProtocol {
    var updateView: ((_ profileModel: ProfileModel) -> ())? { get set }
    func getModel()
    func showMoreInfoViewController()
    func signOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var updateView: ((_ profileModel: ProfileModel) -> ())?
    
    private let profileModel: ProfileModel
    private var output: ProfileOuput
    
    init(profileModel: ProfileModel, output: ProfileOuput) {
        self.profileModel = profileModel
        self.output = output
    }
    
    func getModel() {
        updateView?(profileModel)
    }
    
    func showMoreInfoViewController() {
        output.goToMoreInfoController()
    }
    
    func signOut() {
        AuthManager.shared.signOut()
        output.goToLoginController()
    }
}
