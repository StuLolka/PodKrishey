import UIKit

final class FavoriteViewController: UIViewController {
    private let mainView: HomeViewProtocol
    private var viewModel: FavoriteViewModelProtocol?
    
    init(mainView: HomeViewProtocol) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Global.backgroundViewController
        navigationItem.titleView = CustomNavigationTitle(title: .Favorite.title)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.updateModel(state: .willAppear)
    }
    
    func setViewModel(viewModel: FavoriteViewModelProtocol) {
        self.viewModel = viewModel
        mainView.addToFavoriteAction = viewModel.removeFromFavorite(apartment:)
        updateView()
    }
    
    private func updateView() {
        viewModel?.setErrorView = { text in
            self.view = ErrorView(text: text)
        }
        viewModel?.updateView = { data, reloadCollectionView in
            self.view = self.mainView
            self.mainView.updateCollectionView(with: data, scrollToTop: reloadCollectionView)
        }
    }
    
    private func addToFavoriteAction() {
        
//        mainView.deleteItemAt(indexPath: <#T##IndexPath#>)
    }
}
