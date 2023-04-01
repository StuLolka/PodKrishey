import UIKit

enum ProfileFactory {
    static func getViewController(with coordinator: ProfileCoordinator, viewModel: ProfileModel) -> UIViewController {
        let mainView = ProfileView()
        let vc = ProfileViewController(mainView: mainView)
        let viewModel = ProfileViewModel(profileModel: viewModel, output: coordinator)
        vc.setViewModel(viewModel: viewModel)
//        let coordinator = ProfileCoordinator(navigationController: navigationController)
//        let viewModel = LoginViewModel()
//        viewModel.output = coordinator
//        vc.setViewModel(viewModel: viewModel)
        return vc
    }
}
