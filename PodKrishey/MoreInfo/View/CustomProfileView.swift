import UIKit

final class CustomProfileView: UIView {
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.layer.cornerRadius = Constrains.cornerAvatarImage
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var changeAvatarButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle(.ProfileView.changeAvatar, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 23)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData(avatarName: String) {
        avatarImageView.image = UIImage(named: avatarName)
    }
    
    private func setupView() {
        addSubviews(avatarImageView, changeAvatarButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constrains.avatarImageViewWidth),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            changeAvatarButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            changeAvatarButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            changeAvatarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
}

private extension CustomProfileView {
    enum Constrains {
        static let avatarImageViewWidth: CGFloat = UIScreen.main.bounds.width / 3
        static let cornerAvatarImage: CGFloat = Constrains.avatarImageViewWidth / 2
    }
}
