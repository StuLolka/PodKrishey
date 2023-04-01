import UIKit

final class FullDescriptionApartamentViewController: UIViewController {
    private let mainView: FullDescriptionApartamentViewProtocol
    private var viewModel: FullDescriptionApartamentViewModelProtocol?
    
    init(mainView: FullDescriptionApartamentViewProtocol) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        mainView.setScrollViewContentSize()
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.setScrollViewContentSize()
    }
    
    func setModel(viewModel: FullDescriptionApartamentViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModel?.updateView = setupView(model:)
        self.viewModel?.update()
    }
    
    private func setupView(model: HomeDataModel) {
        view.backgroundColor = .Global.backgroundViewController
        mainView.setModel(model: model)
    }
}
