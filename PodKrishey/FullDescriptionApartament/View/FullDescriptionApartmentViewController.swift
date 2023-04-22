import UIKit

protocol FullDescriptionApartmentViewProtocol: UIView {
    var addToFavoriteAction: (() -> ())? { get set }
    var loadImage: ((String, (@escaping (UIImage?) -> ()))  -> ())? { get set }
    
    func setModel(model: ApartmentModel)
    func setScrollViewContentSize()
}

final class FullDescriptionApartmentViewController: UIViewController {
    private let mainView: FullDescriptionApartmentViewProtocol
    private var viewModel: FullDescriptionApartmentViewModelProtocol?
    
    init(mainView: FullDescriptionApartmentViewProtocol) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.setScrollViewContentSize()
    }
    
    func setModel(viewModel: FullDescriptionApartmentViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModel?.updateView = setupView(model:)
        self.viewModel?.update()
        
        mainView.loadImage = self.viewModel?.loadImage
        mainView.addToFavoriteAction = self.viewModel?.addToFavorite
    }
    
    private func setupView(model: ApartmentModel) {
        view.backgroundColor = .Global.backgroundViewController
        mainView.setModel(model: model)
    }
}
