import UIKit

final class FullDescriptionApartmentCoordinator {
    private let navigationController: UINavigationController
    private let apartment: ApartmentModel
    
    init(navigationController: UINavigationController, apartment: ApartmentModel) {
        self.navigationController = navigationController
        self.apartment = apartment
    }
    
    func show() {
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(FullDescriptionApartmentFactory.getViewController(model: apartment), animated: true)
    }
}
