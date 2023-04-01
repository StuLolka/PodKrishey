import Foundation

protocol HomeViewModelProtocol {
    var updateView: (([HomeDataModel], _ reloadCollectionView: Bool) -> ())? { get set }
    
    func updateModel(state: HomeViewModelState)
    func addLikedApartament(model: HomeDataModel)
    func removeLikedApartament(model: HomeDataModel)
    func goToSearchViewController()
    func showMoreDetails(model: HomeDataModel)
}

enum HomeViewModelState {
    case initial
    case filter(minPrice: Int, maxPrice: Int, roomNumber: Set<Int>)
    case like
}

protocol HomeViewModelDelegate {
    func update(model: [HomeDataModel])
}

final class HomeViewModel: HomeViewModelProtocol {
    var updateView: (([HomeDataModel], _ reloadCollectionView: Bool) -> ())? 
//    var updateModel: (([HomeDataModel]) -> ())?
    var output: HomeOutput?
    
    func updateModel(state: HomeViewModelState) {
        switch state {
        case .initial:
            updateView?(getData(), true)
        case .filter(let minPrice, let maxPrice, let roomNumber):
            print("test minPrice = \(minPrice), maxPrice = \(maxPrice), roomNumber = \(roomNumber)")
            updateView?(filterApartaments(minPrice: minPrice, maxPrice: maxPrice, numberOfRooms: roomNumber), true)
        case .like:
            updateView?(getData(), false)
        }
    }
    
    func addLikedApartament(model: HomeDataModel) {
        ApartamentData.likedApartaments.append(model)
        ApartamentData.apartamentWasLiked(apartament: model)
        updateModel(state: .like)
    }
    
    func removeLikedApartament(model: HomeDataModel) {
        ApartamentData.likedApartaments.removeAll { foundedModel in
            model == foundedModel
        }
    }
    
    func showMoreDetails(model: HomeDataModel) {
        output?.apartamentSelected(apartament: model)
    }
    
    func goToSearchViewController() {
        output?.searchButtonTouched(homeModelDelegate: self)
    }
    
    private func filterApartaments(minPrice: Int, maxPrice: Int, numberOfRooms: Set<Int>) -> [HomeDataModel] {
        ApartamentData.apartaments.filter { model in
            let numberOfRoomsContainsFive = numberOfRooms.contains(5)
            let roomHasMoreThanOrEqualToFiveRooms = model.numberOfRooms >= 5
            let modelMustHaveAndHas = numberOfRoomsContainsFive && roomHasMoreThanOrEqualToFiveRooms
            print("test model.price = \(model.price), minPrice = \(minPrice), maxPrice = \(maxPrice)")
            return model.price >= minPrice && model.price <= maxPrice && (numberOfRooms.contains(model.numberOfRooms) || modelMustHaveAndHas)
        }
    }
    
    private func getData() -> [HomeDataModel] {
        return ApartamentData.apartaments
    }
    
}
