import UIKit

enum FavoriteViewModelState {
    case willAppear
    case like
}

protocol FavoriteViewModelProtocol {
    var updateView: (([ApartmentModel], _ scrollToTop: Bool) -> ())? { get set }
    var setErrorView: ((_ text: String) -> ())? { get set }
    
    func updateModel(state: FavoriteViewModelState)
    func removeFromFavorite(apartment: ApartmentModel)
}

final class FavoriteViewModel: FavoriteViewModelProtocol {
    var updateView: (([ApartmentModel], _ scrollToTop: Bool) -> ())?
    var setErrorView: ((_ text: String) -> ())?
    
    func updateModel(state: FavoriteViewModelState) {
        let favoriteApartments = FirebaseService.shared.getFavoriteApartments()
        print("test favoriteApartments = \(favoriteApartments)")
        switch state {
        case .willAppear:
            guard AuthManager.shared.getIsLoggedIn() else {
                setErrorView?(.Favorite.notAuth)
                return
            }
            if favoriteApartments.isEmpty {
                setErrorView?(.Favorite.none)
                return
            }
            self.updateView?(favoriteApartments, true)
            
        case .like:
            self.updateView?(favoriteApartments, false)
        }
    }
    
    func removeFromFavorite(apartment: ApartmentModel) {
        FirebaseService.shared.updateApartment(apartment)
        updateModel(state: .like)
    }
}
