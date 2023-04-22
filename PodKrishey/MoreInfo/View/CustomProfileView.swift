import UIKit
import SnapKit

final class CustomProfileView: UIView {
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.layer.cornerRadius = Constrains.cornerAvatarImage
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var changeAvatarButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle(.ProfileView.changeAvatar, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 23)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.3
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
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constrains.avatarImageViewWidth)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        changeAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview().inset(8)
        }
    }
}

private extension CustomProfileView {
    enum Constrains {
        static let avatarImageViewWidth: CGFloat = UIScreen.main.bounds.width / 3
        static let cornerAvatarImage: CGFloat = Constrains.avatarImageViewWidth / 2
    }
}
