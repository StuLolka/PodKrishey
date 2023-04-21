import UIKit

protocol HomeOutput {
    func searchButtonTouched(homeModelDelegate: HomeViewModelProtocol)
    func apartamentSelected(apartament: ApartmentModel)
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
    
    fileprivate func showFullDescriptionViewController(apartament: ApartmentModel) {
        let coordinator = FullDescriptionApartmentCoordinator(navigationController: navigationController, apartment: apartament)
        coordinator.show()
    }
}

extension HomeCoordinator: HomeOutput {
    func searchButtonTouched(homeModelDelegate: HomeViewModelProtocol) {
        showSearchViewController(homeModelDelegate: homeModelDelegate)
    }
    
    func apartamentSelected(apartament: ApartmentModel) {
        showFullDescriptionViewController(apartament: apartament)
    }
}
