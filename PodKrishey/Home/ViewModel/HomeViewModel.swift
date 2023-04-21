import UIKit

protocol HomeViewModelProtocol {
    var updateView: (([ApartmentModel], _ reloadCollectionView: Bool) -> ())? { get set }
    
    func updateModel(state: HomeViewModelState)
    func addToFavorite(apartment: ApartmentModel)
    func goToSearchViewController()
    func loadImage(_ url: String, _ handler: @escaping (UIImage?) -> ())
    func showMoreDetails(model: ApartmentModel)
}

enum HomeViewModelState {
    case initial
//    case willAppear
    case filter(minPrice: Int, maxPrice: Int, roomNumber: Set<Int>)
    case like
}

protocol HomeViewModelDelegate {
    func update(model: [ApartmentModel])
}

final class HomeViewModel: HomeViewModelProtocol {
    var updateView: (([ApartmentModel], _ scrollToTop: Bool) -> ())?
    var output: HomeOutput?
    
    func updateModel(state: HomeViewModelState) {
        switch state {
        case .initial: getApartments(true)
            
//        case .willAppear: getApartments(false)
            
        case .filter(let minPrice, let maxPrice, let numberOfRooms):
            filterApartaments(minPrice: minPrice, maxPrice: maxPrice, numberOfRooms: numberOfRooms) { models in
                self.updateView?(models, true)
            }
            
        case .like: getApartments(false)
        }
    }
    
    func addToFavorite(apartment: ApartmentModel) {
        FirebaseService.shared.updateApartment(apartment)
        updateModel(state: .like)
    }
    
    func showMoreDetails(model: ApartmentModel) {
        output?.apartamentSelected(apartament: model)
    }
    
    func goToSearchViewController() {
        output?.searchButtonTouched(homeModelDelegate: self)
    }
    
    func loadImage(_ url: String, _ handler: @escaping (UIImage?) -> ()) {
        FirebaseService.shared.downloadImage(from: url) { image in
            DispatchQueue.main.async {
                handler(image)
            }
        }
    }
    
    private func getApartments(_ scrollToTop: Bool) {
        FirebaseService.shared.getApartments { result in
            switch result {
            case .success(let apartments): self.updateView?(apartments, scrollToTop)
            case .failure(let error): print("Fail: \(error.localizedDescription)")
            }
        }
    }
    
    private func filterApartaments(minPrice: Int, maxPrice: Int, numberOfRooms: Set<Int>, handler: @escaping(([ApartmentModel])) -> ()) {
        FirebaseService.shared.getApartments { result in
            switch result {
                case .success(let apartments):
                    handler(apartments.filter { apartment in
                        let numberOfRoomsContainsFive = numberOfRooms.contains(5)
                        let roomHasMoreThanOrEqualToFiveRooms = apartment.numberOfRooms >= 5
                        let modelMustHaveAndHas = numberOfRoomsContainsFive && roomHasMoreThanOrEqualToFiveRooms
                        return apartment.price >= minPrice && apartment.price <= maxPrice && (numberOfRooms.contains(apartment.numberOfRooms) || modelMustHaveAndHas)
                    })
                case .failure(let error): print("Fail: \(error.localizedDescription)")
            }
        }
    }
    

}
