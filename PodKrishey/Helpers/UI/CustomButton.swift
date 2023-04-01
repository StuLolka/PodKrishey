import UIKit

final class CustomButton: UIView {
    var action: (() -> ())?
    
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.layer.cornerRadius = Constrains.cornerAvatarImage
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.image = UIImage(systemName: "greaterthan")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    init(avatar: UIImage?, title: String, action: @escaping (() -> ())) {
//        self.action = action
//        super.init(frame: .zero)
//        setupView()
//        self.avatarImageView.image = avatar
//        self.nameLabel.text = title
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @objc func tap() {
        action?()
    }
    
    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        addSubviews(avatarImageView, nameLabel, itemImageView)
        addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constrains.avatarImageViewWidth),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constrains.avatarImageViewWidth),
//            avatarImageView.wi
//            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
//            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: -8),
            
            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}

private extension CustomButton {
    enum Constrains {
        static let avatarImageViewWidth: CGFloat = UIScreen.main.bounds.width / 4
        static let cornerAvatarImage: CGFloat = Constrains.avatarImageViewWidth / 2
    }
}
