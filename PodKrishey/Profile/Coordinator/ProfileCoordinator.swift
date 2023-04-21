import UIKit

protocol ProfileOuput {
    func goToMoreInfoController()
    func goToLoginController()
}


final class ProfileCoordinator {
    private let navigationController: UINavigationController
    private let profileModel: ProfileModel
    
    init(navigationController: UINavigationController, viewModel: ProfileModel) {
        self.navigationController = navigationController
        self.profileModel = viewModel
    }
    
    func show() {
        let vc = ProfileFactory.getViewController(with: self, viewModel: profileModel)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    fileprivate func showMoreInfo() {
        let coordinator = MoreInfoCoordinator(navigationController: navigationController, profileModel: profileModel)
        coordinator.show()
    }
    
    fileprivate func showLoginController() {
        navigationController.popViewController(animated: true)
    }
}

extension ProfileCoordinator: ProfileOuput {
    func goToMoreInfoController() {
        showMoreInfo()
    }
    
    func goToLoginController() {
        showLoginController()
    }
}
