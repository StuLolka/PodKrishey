import UIKit

enum HomeFactory {
    static func getViewController() -> UIViewController {
        let mainView = HomeView()
        let vc = HomeViewController(mainView: mainView)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.barTintColor = .Global.blue
        navigationController.navigationBar.backgroundColor = .Global.blue
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let viewModel = HomeViewModel()
        viewModel.output = coordinator
        vc.setViewModel(viewModel: viewModel)
        return navigationController
    }
}
