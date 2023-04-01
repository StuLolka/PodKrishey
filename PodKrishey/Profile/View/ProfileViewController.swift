import UIKit

final class ProfileViewController: UIViewController {
    private let mainView: ProfileView
    private var viewModel: ProfileViewModelProtocol?
    
    init(mainView: ProfileView) {
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
        navigationItem.titleView = CustomNavigationTitle(title: .Profile.title)
    }
    
    func setViewModel(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        self.mainView.userViewAction = viewModel.showMoreInfoViewController
        self.viewModel?.updateView = mainView.addData
        self.viewModel?.getModel()
    }
}
