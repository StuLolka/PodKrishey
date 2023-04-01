import UIKit

protocol ProfileViewProtocol: UIView {
    var userViewAction: (() -> ())? { get set }
}

final class ProfileView: UIView, ProfileViewProtocol {
    var userViewAction: (() -> ())?
    
    private lazy var userView: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .Global.blueGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData(model: ProfileModel) {
        userView.action = userViewAction
        userView.avatarImageView.image = UIImage(named: model.avatarName)
        userView.nameLabel.text = model.name
    }
    
    private func setupView() {
        addSubviews(userView)
        
        NSLayoutConstraint.activate([
            userView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)
            
        ])
    }
    
}
