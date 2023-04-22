import UIKit
import SnapKit

protocol ProfileViewProtocol: UIView {
    var userViewAction: (() -> ())? { get set }
}

final class ProfileView: UIView, ProfileViewProtocol {
    var userViewAction: (() -> ())?
    
    private lazy var userView: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .Global.blueGray
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
        
        userView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
    }
    
}
