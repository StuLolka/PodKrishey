import UIKit

class MoreInfoViewController: UIViewController {
    private let mainView: MoreInfoViewProtocol
    private var viewModel: MoreInfoViewModelProtocol?
    
    init(mainView: MoreInfoViewProtocol) {
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
        setupNavigationBar()
    }
    
    func setViewModel(viewModel: MoreInfoViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModel?.updateView = mainView.addData(data:)
        self.viewModel?.setupView()
    }
    
    private func setupNavigationBar() {
        let edit = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editTouched))
        navigationItem.rightBarButtonItem = edit
    }
    
    @objc func editTouched() {
        
    }
}
