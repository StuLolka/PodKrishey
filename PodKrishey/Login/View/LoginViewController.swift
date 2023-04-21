import UIKit

protocol LoginViewProtocol: UIView {
    var loginAction: ((_ login: String?, _ password: String?) -> ())? { get set }
    
    func changeNotificationFrame(_ frame: CGRect)
}

final class LoginViewController: UIViewController {
    private let mainView: LoginViewProtocol
    private var viewModel: LoginViewModelProtocol?
    
    private var seconds = 0
    private var timer: Timer?
    
    init(mainView: LoginViewProtocol) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
        mainView.loginAction = loginButtonTouched
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .Global.backgroundViewController
        navigationItem.titleView = CustomNavigationTitle(title: .Login.title)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showHint()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNotification()
        seconds = 0
        timer?.invalidate()
        timer = nil
    }
    
    func setViewModel(viewModel: LoginViewModelProtocol?) {
        self.viewModel = viewModel
        self.viewModel?.showAlert = showAlert
    }
    
    private func showHint() {
        let navBarOriginY = navigationController?.navigationBar.frame.origin.y ?? 47
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 44
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.mainView.changeNotificationFrame(CGRect(x: 10, y: navBarOriginY + navBarHeight + 10, width: Constants.Profile.notificationWidth, height: Constants.Profile.notificationHeight))
            self.view.layoutIfNeeded()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func checkTimer() {
        seconds += 1
        guard seconds == 7 else { return }
        hideNotification()
        seconds = 0
        timer?.invalidate()
        timer = nil
    }
    
    private func hideNotification() {
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.mainView.changeNotificationFrame(CGRect(x: 10, y: -Constants.Profile.notificationHeight, width: Constants.Profile.notificationWidth, height: Constants.Profile.notificationHeight))
            self.view.layoutIfNeeded()
        }
    }
    
    private func loginButtonTouched(_ login: String?, _ password: String?) {
        viewModel?.login(login: login, password: password)
    }
    
    private func showAlert(with error: String) {
        let alert = UIAlertController(title: error, message: "Попробуйте снова", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
