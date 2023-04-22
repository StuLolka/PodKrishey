import UIKit
import FirebaseAuth
import SnapKit

final class LoginView: UIView, LoginViewProtocol {
    var loginAction: ((_ login: String?, _ password: String?) -> ())?
    
    private lazy var notificationView: NotificationView = {
        let notificationView = NotificationView(title: .Login.notification)
        notificationView.frame = CGRect(x: 10, y: -Constants.Profile.notificationHeight, width: Constants.Profile.notificationWidth, height: Constants.Profile.notificationHeight)
        notificationView.backgroundColor = .systemGray6
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        return notificationView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        textField.placeholder = .Login.loginPlaceholder
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        
        textField.text = LoginInspector.shared.getTrueValuesTest().0
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        textField.placeholder = .Login.passwordPlaceholder
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        
        textField.text = LoginInspector.shared.getTrueValuesTest().1
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle(.Login.buttonTitle, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubviews(loginTextField, passwordTextField, loginButton)
        stackView.spacing = 10
        stackView.setCustomSpacing(20, after: passwordTextField)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tap() {
        endEditing(true)
    }
    
    @objc private func loginButtonTouched() {
        loginAction?(loginTextField.text, passwordTextField.text)
    }
    
    func changeNotificationFrame(_ frame: CGRect) {
        notificationView.frame = frame
    }

    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tap)
        
        addSubviews(notificationView, stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
    }
}
