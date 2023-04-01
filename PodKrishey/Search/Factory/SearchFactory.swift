import UIKit

enum SearchFactory {
    private static let mainView = SearchView()
    static func getViewController(output: SearchOutput) -> UIViewController {
        let vc = SearchViewController(mainView: SearchFactory.mainView)
        vc.output = output
//        let viewModel = HomeDataViewModel(state: .initial)
//        vc.setModel(viewModel: viewModel)
        return vc
    }
}
