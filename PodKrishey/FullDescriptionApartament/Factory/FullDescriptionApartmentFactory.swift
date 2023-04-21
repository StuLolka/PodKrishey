import UIKit

enum FullDescriptionApartmentFactory {
    static func getViewController(model: ApartmentModel) -> UIViewController {
        let mainView = FullDescriptionApartmentView()
        let vc = FullDescriptionApartmentViewController(mainView: mainView)
        let viewModel = FullDescriptionApartmentViewModel(model: model)
        vc.setModel(viewModel: viewModel)
        return vc
    }
}
