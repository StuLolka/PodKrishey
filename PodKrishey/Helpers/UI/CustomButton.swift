import UIKit
import SnapKit

final class CustomButton: UIView {
    var action: (() -> ())?
    
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.layer.cornerRadius = Constrains.cornerAvatarImage
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.image = UIImage(systemName: "greaterthan")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tap() {
        action?()
    }
    
    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        addSubviews(avatarImageView, nameLabel, itemImageView)
        addGestureRecognizer(tap)
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(Constrains.avatarImageViewWidth)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp_trailingMargin).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(itemImageView.snp_leadingMargin).offset(8)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
        }
    }
}

private extension CustomButton {
    enum Constrains {
        static let avatarImageViewWidth: CGFloat = UIScreen.main.bounds.width / 4
        static let cornerAvatarImage: CGFloat = Constrains.avatarImageViewWidth / 2
    }
}
