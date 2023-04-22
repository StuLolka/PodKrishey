import UIKit

enum FavoriteViewModelState {
    case willAppear
    case removeFromFavorite
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
        
        guard AuthManager.shared.getIsLoggedIn() else {
            setErrorView?(.Favorite.notAuth)
            return
        }
        if favoriteApartments.isEmpty {
            setErrorView?(.Favorite.none)
            return
        }
        
        switch state {
        case .willAppear:
            self.updateView?(favoriteApartments, true)
            
        case .removeFromFavorite:
            self.updateView?(favoriteApartments, false)
        }
    }
    
    func removeFromFavorite(apartment: ApartmentModel) {
        FirebaseService.shared.updateApartment(apartment)
        updateModel(state: .removeFromFavorite)
    }
}
