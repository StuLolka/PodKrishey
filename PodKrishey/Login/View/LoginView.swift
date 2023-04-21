import UIKit
import FirebaseAuth

final class LoginView: UIView, LoginViewProtocol {
    var loginAction: ((_ login: String?, _ password: String?) -> ())?
    
    private lazy var notificationView: NotificationView = {
        let notificationView = NotificationView(title: "Введите логин и пароль, чтобы войти в личный кабинет")
        notificationView.frame = CGRect(x: 10, y: -Constants.Profile.notificationHeight, width: Constants.Profile.notificationWidth, height: Constants.Profile.notificationHeight)
        notificationView.backgroundColor = .systemGray6
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        return notificationView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        textField.placeholder = "Номер телефона или почта"
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.text = LoginInspector.shared.getTrueValuesTest().0
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        textField.placeholder = "Пароль"
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.text = LoginInspector.shared.getTrueValuesTest().1
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubviews(loginTextField, passwordTextField, loginButton)
        stackView.spacing = 10
        stackView.setCustomSpacing(20, after: passwordTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tap() {
        endEditing(true)
    }
    
    @objc func loginButtonTouched() {
        loginAction?(loginTextField.text, passwordTextField.text)
    }
    
    func changeNotificationFrame(_ frame: CGRect) {
        notificationView.frame = frame
    }

    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tap)
        
        addSubviews(notificationView, stackView)
        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 32),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 32),
            
            loginButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
