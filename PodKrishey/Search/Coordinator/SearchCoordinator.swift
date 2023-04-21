import UIKit

protocol SearchOutput {
    func searchButtonTouched(minPrice: Int, maxPrice: Int, roomNumber: Set<Int>)
    func resetButtonTouched()
    func tapToDismiss()
}

final class SearchCoordinator {
    var homeModelDelegate: HomeViewModelProtocol?
    
    private let navigationController: UINavigationController
    
    private let mainView = SearchView()
    private lazy var controller = SearchViewController(mainView: mainView)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        controller.output = self
        navigationController.present(controller, animated: true)
    }
    
    fileprivate func resetFilters() {
        homeModelDelegate?.updateModel(state: .initial)
        navigationController.dismiss(animated: true)
    }
    
    fileprivate func findApartments(minPrice: Int, maxPrice: Int, roomNumber: Set<Int>) {
        homeModelDelegate?.updateModel(state: .filter(minPrice: minPrice, maxPrice: maxPrice, roomNumber: roomNumber))
        navigationController.dismiss(animated: true)
    }
    
    fileprivate func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

extension SearchCoordinator: SearchOutput {
    func searchButtonTouched(minPrice: Int, maxPrice: Int, roomNumber: Set<Int>) {
        findApartments(minPrice: minPrice, maxPrice: maxPrice, roomNumber: roomNumber)
    }
    
    func resetButtonTouched() {
        resetFilters()
    }
    
    func tapToDismiss() {
        dismiss()
    }
}
