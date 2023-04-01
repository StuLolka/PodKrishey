import UIKit

final class SearchViewController: UIViewController {
    var output: SearchOutput?
    private let mainView: SearchViewProtocol
    
    private var timer: Timer?
    
    init(mainView: SearchViewProtocol) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func loadView() {
    //        view = mainView
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .clear
        view.addSubview(mainView)
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2)
        ])
        
        mainView.searchAction = output?.searchButtonTouched
        mainView.resetAction = output?.resetButtonTouched
        mainView.priceErrorAction = showNotification
        mainView.backgroundColor = .Global.backgroundViewController
        navigationItem.titleView = CustomNavigationTitle(title: .Search.title)
    }
    
    private func showNotification() {
//        let navBarOriginY = navigationController?.navigationBar.frame.origin.y ?? 47
//        let navBarHeight = navigationController?.navigationBar.frame.height ?? 44
        
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            self.mainView.changeNotificationFrame(CGRect(x: 10, y: 10, width: Constants.Profile.notificationWidth, height: Constants.Profile.notificationHeight))
            self.view.layoutIfNeeded()
        }
        timer = Timer.scheduledTimer (withTimeInterval: 3.5, repeats: false) { _ in
            self.hideNotification()
        }
    }
    
    private func hideNotification() {
        timer?.invalidate()
        timer = nil
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            self.mainView.changeNotificationFrame(CGRect(x: 10, y: -Constants.Profile.notificationHeight, width: Constants.Profile.notificationWidth, height: Constants.Profile.notificationHeight))
            self.view.layoutIfNeeded()
        }
    }
}
