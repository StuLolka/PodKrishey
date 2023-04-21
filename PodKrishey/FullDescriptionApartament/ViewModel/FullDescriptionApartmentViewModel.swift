import UIKit

protocol FullDescriptionApartmentViewModelProtocol {
    var updateView: ((_ model: ApartmentModel) -> ())? { get set }
    
    func update()
    func loadImage(_ url: String, _ handler: @escaping (UIImage?) -> ())
    func addToFavorite()
}

final class FullDescriptionApartmentViewModel: FullDescriptionApartmentViewModelProtocol {
    var updateView: ((_ model: ApartmentModel) -> ())?
    private let model: ApartmentModel
    
    init(model: ApartmentModel) {
        self.model = model
    }
    
    func update() {
        updateView?(model)
    }
    
    func loadImage(_ url: String, _ handler: @escaping (UIImage?) -> ()) {
        FirebaseService.shared.downloadImage(from: url) { image in
            DispatchQueue.main.async {
                handler(image)
            }
        }
    }
    
    func addToFavorite() {
        FirebaseService.shared.updateApartment(model)
        update()
    }
}
