import UIKit

protocol MoreInfoViewModelProtocol {
    var updateView: ((_ model: ProfileModel) -> ())? { get set }
    
    func setupView()
}

final class MoreInfoViewModel: MoreInfoViewModelProtocol {
    var updateView: ((_ model: ProfileModel) -> ())?
    
    private let model: ProfileModel
    
    init(model: ProfileModel) {
        self.model = model
    }
    
    func setupView() {
        updateView?(model)
    }
}
