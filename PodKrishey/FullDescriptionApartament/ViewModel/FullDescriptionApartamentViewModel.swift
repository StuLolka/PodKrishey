import UIKit

protocol FullDescriptionApartamentViewModelProtocol {
    var updateView: ((_ model: HomeDataModel) -> ())? { get set }
    
    func update()
}

final class FullDescriptionApartamentViewModel: FullDescriptionApartamentViewModelProtocol {
    var updateView: ((_ model: HomeDataModel) -> ())?
    private let model: HomeDataModel
    
    init(model: HomeDataModel) {
        self.model = model
    }
    
    func update() {
        updateView?(model)
    }
}
