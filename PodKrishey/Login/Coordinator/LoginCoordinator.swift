import UIKit

protocol LoginOuput {
    func goToProfile(viewModel: ProfileModel)
}


final class LoginCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    fileprivate func showProfile(viewModel: ProfileModel) {
        let coordinator = ProfileCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.show()
    }
}

extension LoginCoordinator: LoginOuput {
    func goToProfile(viewModel: ProfileModel) {
        showProfile(viewModel: viewModel)
    }
}
