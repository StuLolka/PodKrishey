import UIKit

final class HomeViewController: UIViewController {
    private let mainView: HomeViewProtocol
    private var viewModel: HomeViewModelProtocol?
    
    init(mainView: HomeViewProtocol) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.loadImage = viewModel?.loadImage(_:_:)
        
        mainView.likeAction = addFavoriteApartment(model:)
        mainView.didSelectApartment = { item in
            self.viewModel?.showMoreDetails(model: item)
        }
        
        mainView.backgroundColor = .Global.backgroundViewController
        navigationItem.titleView = CustomNavigationTitle(title: .Home.title)
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel?.updateModel(state: .willAppear)
    }

    
    func setViewModel(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        updateView()
    }
    
    private func updateView() {
        viewModel?.updateView = { data, reloadCollectionView in
            self.mainView.updateCollectionView(with: data, scrollToTop: reloadCollectionView)
        }
        viewModel?.updateModel(state: .initial)
    }
    
    @objc func searchButtonTouched() {
        viewModel?.goToSearchViewController()
    }
    
    private func setNavigationBar() {
        let searchButton = UIBarButtonItem(image: .Home.magnifyingglass, style: .plain, target: self, action: #selector(searchButtonTouched))
        searchButton.tintColor = .black
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func addFavoriteApartment(model: ApartmentModel) {
        viewModel?.addToFavorite(apartment: model)
    }
}
