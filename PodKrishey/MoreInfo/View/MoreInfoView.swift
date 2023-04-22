import UIKit
import SnapKit

protocol MoreInfoViewProtocol: UIView {
    func addData(data: ProfileModel)
}

final class MoreInfoView: UIView, MoreInfoViewProtocol {
    private lazy var customView: CustomProfileView = {
        let view = CustomProfileView()
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
    
    func addData(data: ProfileModel) {
        customView.addData(avatarName: data.avatarName)
    }
    
    private func setupView() {
        addSubviews(customView)
        
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
}


