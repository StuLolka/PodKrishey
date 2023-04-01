import UIKit

final class FullDescriptionApartamentCoordinator {
    private let navigationController: UINavigationController
    private let apartament: HomeDataModel
    
    init(navigationController: UINavigationController, apartament: HomeDataModel) {
        self.navigationController = navigationController
        self.apartament = apartament
    }
    
    func show() {
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(FullDescriptionApartamentFactory.getViewController(model: apartament), animated: true)
    }
}
