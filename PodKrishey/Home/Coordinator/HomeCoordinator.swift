import UIKit

protocol HomeOutput {
    func searchButtonTouched(homeModelDelegate: HomeViewModelProtocol)
    func apartamentSelected(apartament: HomeDataModel)
}

final class HomeCoordinator {
    private let navigationController: UINavigationController
    
    private lazy var searchCoordinator = SearchCoordinator(navigationController: navigationController)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    fileprivate func showSearchViewController(homeModelDelegate: HomeViewModelProtocol) {
        searchCoordinator.homeModelDelegate = homeModelDelegate
        searchCoordinator.show()
    }
    
    fileprivate func showFullDescriptionViewController(apartament: HomeDataModel) {
        let coordinator = FullDescriptionApartamentCoordinator(navigationController: navigationController, apartament: apartament)
        coordinator.show()
    }
}

extension HomeCoordinator: HomeOutput {
    func searchButtonTouched(homeModelDelegate: HomeViewModelProtocol) {
        showSearchViewController(homeModelDelegate: homeModelDelegate)
    }
    
    func apartamentSelected(apartament: HomeDataModel) {
        showFullDescriptionViewController(apartament: apartament)
    }
}
