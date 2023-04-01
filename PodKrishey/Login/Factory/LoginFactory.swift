import UIKit

enum LoginFactory {
    static func getViewController() -> UIViewController {
        let mainView = LoginView()
        let vc = LoginViewController(mainView: mainView)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.barTintColor = .Global.blue
        navigationController.navigationBar.backgroundColor = .Global.blue
        let coordinator = LoginCoordinator(navigationController: navigationController)
        let viewModel = LoginViewModel()
        viewModel.output = coordinator
        vc.setViewModel(viewModel: viewModel)
        return navigationController
    }
}
