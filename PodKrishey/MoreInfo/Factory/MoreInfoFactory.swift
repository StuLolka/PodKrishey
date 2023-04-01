import UIKit

enum MoreInfoFactory {
    static func getViewController(model: ProfileModel) -> UIViewController {
        let vc = MoreInfoViewController(mainView: MoreInfoView())
        let viewModel = MoreInfoViewModel(model: model)
        vc.setViewModel(viewModel: viewModel)
        return vc
    }
}
