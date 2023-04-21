import UIKit

enum FavoriteFactory {
    static func getViewController() -> UIViewController {
        let mainView = ApartmentsView()
        let vc = FavoriteViewController(mainView: mainView)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.barTintColor = .Global.blue
        navigationController.navigationBar.backgroundColor = .Global.blue
//        let coordinator = HomeCoordinator(navigationController: navigationController)
        let viewModel = FavoriteViewModel()
//        viewModel.output = coordinator
        vc.setViewModel(viewModel: viewModel)
        return navigationController
    }
}
