import UIKit

protocol ProfileOuput {
    func goToMoreInfo()
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
}

extension ProfileCoordinator: ProfileOuput {
    func goToMoreInfo() {
        showMoreInfo()
    }
}
