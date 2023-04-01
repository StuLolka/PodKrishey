import UIKit

protocol MoreInfoOutput {
    func editTouched()
}

final class MoreInfoCoordinator {
    private let navigationController: UINavigationController
    private let profileModel: ProfileModel
    
    init(navigationController: UINavigationController, profileModel: ProfileModel) {
        self.navigationController = navigationController
        self.profileModel = profileModel
    }
    
    func show() {
        let vc = MoreInfoFactory.getViewController(model: profileModel)
        navigationController.present(vc, animated: true)
    }
    
    fileprivate func editEnable() {
        
    }
}

extension MoreInfoCoordinator: MoreInfoOutput {
    func editTouched() {
        ///
    }
}
