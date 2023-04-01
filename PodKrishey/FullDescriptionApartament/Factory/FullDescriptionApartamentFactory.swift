import UIKit

enum FullDescriptionApartamentFactory {
    static func getViewController(model: HomeDataModel) -> UIViewController {
        let mainView = FullDescriptionApartamentView()
        let vc = FullDescriptionApartamentViewController(mainView: mainView)
        let viewModel = FullDescriptionApartamentViewModel(model: model)
        vc.setModel(viewModel: viewModel)
        return vc
    }
}
